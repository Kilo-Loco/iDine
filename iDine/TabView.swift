//
//  TabView.swift
//  iDine
//
//  Created by Kyle Lee on 7/9/19.
//  Copyright © 2019 Kyle Lee. All rights reserved.
//

import SwiftUI

struct TabView : View {
    var body: some View {
        TabbedView {
            ContentView()
                .tabItem {
                    VStack {
                        Image("system-list")
                        Text("Menu")
                    }
                }.tag(0)
            
            OrderView()
                .tabItem {
                    VStack {
                        Image("system-compose")
                        Text("Order")
                    }
                }.tag(1)
        }
    }
}

#if DEBUG
struct TabView_Previews : PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        TabView().environmentObject(order)
    }
}
#endif
