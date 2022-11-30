//
//  ProfileViewModel.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 18.10.2022.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var profile: MVUser
    @Published var orders: [Order] = [Order]()
    
    init(profile: MVUser){
        self.profile = profile
    }
    
    func getOrders(){
        DataBaseService.shared.getOrdders(by: AuthService.shared.currentUser?.uid) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                
                for (index, order) in self.orders.enumerated(){
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result{
                            
                        case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
                print("всего заказов \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func setProfile(){
        DataBaseService.shared.setProfile(user: self.profile) { result in
            switch result{
                
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func getProfile() {
        DataBaseService.shared.getProfile { result in
            switch result{
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

