//
//  DataBaseService.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 15.10.2022.
//

import Foundation
import FirebaseFirestore

class DataBaseService{
    
    static let shared = DataBaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference{
        return db.collection("users")
    }
    
    private var ordersReference: CollectionReference{
        return db.collection("orders")
    }
    
    private init(){ }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()){
        
        let positionsRef = ordersReference.document(orderID).collection("positions")
        
        positionsRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var positions = [Position]()
                
                for doc in qSnap.documents{
                    if let position = Position(doc: doc){
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
        
    }
    
    func getOrdders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()){
        self.ordersReference.getDocuments { qSnap, error in
            
            if let qSnap = qSnap{
                var orders = [Order]()
                for doc in qSnap.documents{
                    if let userID = userID{
                        if let order = Order(doc: doc), order.userID == userID{
                            orders.append(order)
                        }
                    } else {
                        if let order = Order(doc: doc){
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func setOrder(order: Order, completion: @escaping(Result<Order, Error>) -> () ){
        
        ordersReference.document(order.id).setData(order.representation) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                self.setPositions(to: order.id, positions: order.positions) { res in
                    switch res{
                        
                    case .success(let positioons):
                        print(positioons.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                completion(.success(order))
            }
            
        }
        
    }
    
    func setPositions(to orderID: String, positions:[Position], completion: @escaping(Result<[Position], Error>) -> ()){
        
        let positionsRef = ordersReference.document(orderID).collection("positions")
        
        for pos in positions{
            
            positionsRef.document(pos.id).setData(pos.representation)
            
        }
        
        completion(.success(positions))
        
    }
    
    func setProfile(user: MVUser, completion: @escaping (Result<MVUser, Error>) -> ()){
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(completion: @escaping (Result <MVUser, Error>) -> ()){
        usersRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else{ return }
            
            guard let data = snap.data() else { return }
            
            guard let userName = data["name"] as? String else { return }
            
            guard let id = data["id"] as? String else { return }
            
            guard let phone = data["phone"] as? Int else { return }
            
            guard let address = data["address"] as? String else { return }
            
            let user = MVUser(id: id, name: userName, phone: phone, address: address)
            
            completion(.success(user))
            
            
        }
    }
    
    
}




