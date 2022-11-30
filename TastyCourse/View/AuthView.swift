//
//  ContentView.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 10.10.2022.
//

import SwiftUI

struct AuthView: View {
    @State private var eMail = ""
    @State private var enterPassword = ""
    @State private var isAuth = true
    @State private var confirmPassword = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    
    
    
    
    var body: some View {
        VStack(spacing: 45){
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 16 : 24)
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .foregroundColor(.white)
                .background(Color("Steel"))
                .cornerRadius(isAuth ? 25 : 50)
            
            VStack{
                TextField("Введите E-mail", text: $eMail)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Steel"))
                    .cornerRadius(15)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                
                SecureField("Введите пароль", text: $enterPassword)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Steel"))
                    .cornerRadius(15)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if !isAuth {
                    SecureField("Введите пароль", text: $confirmPassword)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("Steel"))
                        .cornerRadius(15)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                Button {
                    if isAuth{
                        print("Авторизация")
                        
                        AuthService.shared.singIn(email: self.eMail, password: self.enterPassword) { result in
                            switch result{
                                
                            case .success(_):
                                
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                        

                    } else {
                        print("Регистрация")
                        guard enterPassword == confirmPassword else {
                            self.alertMessage = "Пароли не совпадают"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        AuthService.shared.singUp(email: self.eMail, password: self.enterPassword) { result in
                            switch result{
                                
                            case .success(let user):
                                alertMessage = "Вы зарегистрировались с e-mail \(user.email!)"
                                self.isShowAlert.toggle()
                                self.eMail = ""
                                self.confirmPassword = ""
                                self.enterPassword = ""
                                isAuth.toggle()
                                
                            case .failure(let error):
                                
                                self.alertMessage = "Ошибка регистрации \(error.localizedDescription)!"
                                self.isShowAlert.toggle()

                            }
                        }
                        

                    }

                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(LinearGradient(colors: [Color("Yellow"), Color("Orange")], startPoint: .leading, endPoint: .trailing))
                        .font(.title3.bold())
                        .cornerRadius(15)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Уже есть аккаунт!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .font(.title3.bold())
                }
                
            }
            .padding()
            .padding(.top, 16)
            .background(Color("StackBack"))
            .cornerRadius(25)
            .padding(isAuth ? 30 : 12)
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button {
                    
                } label: {
                    Text("Ok")
                }

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("pizza")
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 6)
            )
            .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {
                
                let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                
                MainTabBarView(viewModel: mainTabBarViewModel)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
