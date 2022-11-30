//
//  MainTabBarViewModel.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 15.10.2022.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject{
    @Published var user: User
    
    init(user: User){
        self.user = user
    }
}

