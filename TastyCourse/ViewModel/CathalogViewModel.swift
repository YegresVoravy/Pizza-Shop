//
//  CathalogViewModel.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import Foundation


class CathalogViewModel: ObservableObject{
    
    static let shared = CathalogViewModel()
    

    
    var popularProducts = [
        Product(id: "1",
                title: "Маргарита",
                imageUrl: "Not found",
                price: 400,
                descript: "сама бомжатская пицца"),
        Product(id: "2",
                title: "Пеперони",
                imageUrl: "Not found",
                price: 450,
                descript: "сама бомжатская пицца"),
        Product(id: "3",
                title: "Гавайская",
                imageUrl: "Not found",
                price: 500,
                descript: "сама бомжатская пицца"),
        Product(id: "4",
                title: "Мясная",
                imageUrl: "Not found",
                price: 700,
                descript: "сама бомжатская пицца")]
    
    
    var products = [
        Product(id: "1",
                title: "Маргарита",
                imageUrl: "Not found",
                price: 400,
                descript: "сама бомжатская пицца"),
        Product(id: "2",
                title: "Пеперони",
                imageUrl: "Not found",
                price: 450,
                descript: "сама бомжатская пицца"),
        Product(id: "3",
                title: "Гавайская",
                imageUrl: "Not found",
                price: 500,
                descript: "сама бомжатская пицца"),
        Product(id: "4",
                title: "Мясная",
                imageUrl: "Not found",
                price: 700,
                descript: "сама бомжатская пицца"),
        Product(id: "5",
                title: "Маргарита",
                imageUrl: "Not found",
                price: 400,
                descript: "сама бомжатская пицца"),
        Product(id: "6",
                title: "Пеперони",
                imageUrl: "Not found",
                price: 450,
                descript: "сама бомжатская пицца"),
        Product(id: "7",
                title: "Гавайская",
                imageUrl: "Not found",
                price: 500,
                descript: "сама бомжатская пицца"),
        Product(id: "8",
                title: "Мясная",
                imageUrl: "Not found",
                price: 700,
                descript: "сама бомжатская пицца")]

    
    
}
