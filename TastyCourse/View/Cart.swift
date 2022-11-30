//
//  Cart.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI

struct Cart: View {
    
   @StateObject var viewModel: CartViewModel
    
    
    var body: some View {
        VStack{
            
            List(viewModel.positions){ position in
                
                PositionCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("удалить")
                        }.tint(.red)

                    }
                
            }
            .listStyle(.plain)
            .navigationTitle("Корзина")
            
            HStack{
                Text("Итого:")
                    .fontWeight(.bold)
                Spacer()
                Text("\(self.viewModel.cost) ₽")
                    .fontWeight(.bold)
            }
            .padding()
            
            HStack(spacing: 24){
                
                Button {
                    print("Cancel")
                } label: {
                    Text("Отменить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(25)
                }
                
                Button {
                    print("Заказать")
                    
                    var order = Order(userID: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.new.rawValue)
                    
                    order.positions = self.viewModel.positions
                    
                    DataBaseService.shared.setOrder(order: order) { result in
                        
                        switch result{
                            
                        case .success(let order):
                            print(order.cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                } label: {
                    Text("Оформить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(25)

                }


                
            }
            .padding()
        }
        
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart(viewModel: CartViewModel.shared)
    }
}
