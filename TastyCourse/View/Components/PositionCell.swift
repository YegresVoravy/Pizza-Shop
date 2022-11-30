//
//  PositionCell.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 14.10.2022.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    
    var body: some View {
        HStack{
            Text(position.product.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(position.count) шт.")
            
            Text("\(position.cost) ₽")
                .frame(width: 75, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString, title: "Маргарита", imageUrl: "PizzaPlaceHolder", price: 350, descript: "..."), count: 3))
    }
}
