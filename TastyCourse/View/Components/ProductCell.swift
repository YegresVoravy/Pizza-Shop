//
//  ProductCell.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI

struct ProductCell: View {
    
    var product: Product
    
    var body: some View {
        
        VStack(spacing: 2){
            Image("pizzaPlaceHolder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
                .cornerRadius(15)
            HStack{
                
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
                
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 6)
            
            
        }.frame(width: screen.width * 0.45, height: screen.height * 0.25)
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 4)

        
        
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1", title: "Маргарита", imageUrl: "Not found", price: 450, descript: "сама бомжатская пицца"))
    }
}
