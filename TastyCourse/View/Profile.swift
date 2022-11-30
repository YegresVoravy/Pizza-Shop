//
//  Profile.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI



struct Profile: View {
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    
    @StateObject var viewModel: ProfileViewModel
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            HStack(spacing: 16){
                Image("UserIcon")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color("LightGray"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку?", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галлереи")
                        }
                        
                        Button {
                            print("Камера")
                        } label: {
                            Text("С камеры")
                        }
                    }
                
                
                VStack(alignment: .leading, spacing: 12){
                    TextField("Имя Фамилия", text: $viewModel.profile.name)
                        .font(.body.bold())
                        
                    HStack{
                        Text("+7")
                        TextField("0000000000", value: $viewModel.profile.phone, format: .number )
                    }
                }
            }
            VStack(alignment: .leading, spacing: 8){
                
                Text("Адес доставки:")
                    .bold()
                TextField("Ваш адрес", text: $viewModel.profile.address)
            }
            .padding(.horizontal)
            
            List{
                if viewModel.orders.count == 0{
                    Text("ваши заказы будут тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }

            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .bold()
                    .padding()
                    .padding(.horizontal, 30)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(20)
            }
            .padding()
            .confirmationDialog("Вы уверены, что хотите выйти?", isPresented: $isQuitAlertPresented) {
                Button {
                    isAuthViewPresented.toggle()
                } label: {
                    Text("Да")
                }
                
            }
            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                AuthView()
            }
            
        }
        .onSubmit {
            viewModel.setProfile()
            print("OnSubmit")
        }
        .onAppear{
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(viewModel: ProfileViewModel(profile: MVUser(id: "", name: "Имя", phone: 9859963626, address: "Москва")))
    }
    

    
    
    
}
