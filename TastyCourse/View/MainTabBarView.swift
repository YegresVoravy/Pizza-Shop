//
//  MainTabBarView.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI

struct MainTabBarView: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView{
            NavigationView{
                Cathalog()
            }
            .tabItem {
                VStack{
                    Image(systemName: "menucard")
                    Text("Каталог")
                }
            }
            NavigationView{
                Cart(viewModel: CartViewModel.shared)
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Корзина")
            }
            NavigationView{
                Profile(viewModel: ProfileViewModel(profile: MVUser(id: "", name: "", phone: 0000000000, address: "")))
            }
            .tabItem {
                Image(systemName: "person.circle")
                Text("Профиль")
            }
            
            
        }
        
    }
}

