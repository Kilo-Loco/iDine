//
//  ItemRow.swift
//  iDine
//
//  Created by Kyle Lee on 7/9/19.
//  Copyright © 2019 Kyle Lee. All rights reserved.
//

import SwiftUI

struct ItemRow : View {
    static let colors: [String: Color] = ["D": .purple,
                                          "G": .black,
                                          "N": .red,
                                          "S": .blue,
                                          "V": .green]
    var item: MenuItem
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationLink(destination: ItemDetail(item: item).environmentObject(order)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("$\(item.price)")
                }
                
                Spacer()
                
                ForEach(item.restrictions.identified(by: \.self)) { restriction in
                    Text(restriction)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(5)
                        .background(Self.colors[restriction, default: .black])
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#if DEBUG
struct ItemRow_Previews : PreviewProvider {
    static let order = Order()
    static var previews: some View {
        ItemRow(item: MenuItem.example).environmentObject(order)
    }
}
#endif
