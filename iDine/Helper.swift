//
//  Helper.swift
//  A small collection of quick helpers to avoid repeating the same old code.
//
//  Created by Paul Hudson on 23/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

extension UIApplication {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension Encodable {
    @discardableResult
    func save(to filename: String) -> Bool {
        let url = UIApplication.documentsDirectory.appendingPathComponent(filename)

        do {
            let encoded = try JSONEncoder().encode(self)
            try encoded.write(to: url)
        } catch {
            return false
        }

        return true
    }
}

extension Decodable {
    init?(from filename: String) {
        let url = UIApplication.documentsDirectory.appendingPathComponent(filename)

        guard let data = try? Data(contentsOf: url) else {
            return nil
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(Self.self, from: data) else {
            return nil
        }

        self = loaded
    }
}

extension Data {
    func send(to address: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: address) else {
            fatalError("Invalid URL: \(address)")
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = self

        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
