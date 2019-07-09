//
//  ItemDetail.swift
//  iDine
//
//  Created by Kyle Lee on 7/9/19.
//  Copyright © 2019 Kyle Lee. All rights reserved.
//

import SwiftUI

struct ItemDetail : View {
    var item: MenuItem
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .offset(x: -5, y: -5)
            }
            
            Text(item.description)
                .lineLimit(nil)
                .padding()
            
            Button(action: {
                self.order.add(item: self.item)
            }) {
                Text("Order this")
                    .font(.headline)
            }
            
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

#if DEBUG
struct ItemDetail_Previews : PreviewProvider {
    static var previews: some View {
        ItemDetail(item: MenuItem.example)
    }
}
#endif
