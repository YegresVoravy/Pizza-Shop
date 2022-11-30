//
//  ProductDetailView.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDetailViewModel
    @State var size = "Маленькая"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
        VStack(alignment: .leading){
            Image("pizzaPlaceHolder")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 260)
            HStack{
                Text("\(viewModel.product.title)")
                    .font(.title2.bold())
                Spacer()
                Text("\(viewModel.getPrice(size: self.size) ) ₽")
                    .font(.title2)
            }.padding(.horizontal)
            
            Text("\(viewModel.product.descript)")
                .padding(.horizontal)
                .padding(.vertical, 4)

            HStack{
            Stepper("Количество", value: $count, in: 1...10)

            Text("\(self.count)")
                    .padding(.leading, 32)
            }
            .padding(.horizontal)
            Picker("Размер пиццы", selection: $size) {
                ForEach(viewModel.sizes, id: \.self) { item in
                    Text(item)
                }
            }.pickerStyle(.segmented)
                .padding()
            


            

            
        }
            Button {
                
                var position = Position(id: UUID().uuidString, product: viewModel.product, count: self.count)
                
                position.product.price = viewModel.getPrice(size: size)
                
                CartViewModel.shared.addPosition(position)
                
                presentationMode.wrappedValue.dismiss()
                
                
            } label: {
                Text("В корзину")
            }
            .padding()
            .padding(.horizontal, 60)
            .background(LinearGradient(colors: [Color("Yellow"), Color("Orange")], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.black)
            .font(.title3.bold())
            .cornerRadius(30)

        }

        
        
        Spacer()

    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(
            id: "1",
            title: "Маргарита",
            imageUrl: "Not found",
            price: 450,
            descript: "сама бомжатская пицца")))
    }
}
