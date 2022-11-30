//
//  Cathalog.swift
//  TastyCourse
//
//  Created by AlkoFitoNiashka on 11.10.2022.
//

import SwiftUI

struct Cathalog: View {
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярные") {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 12) {
                        ForEach(CathalogViewModel.shared.popularProducts, id: \.id){ item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }


                        }
                    }.padding()
                }
                
            }
            Section("Пицца"){

                ScrollView(.vertical, showsIndicators: false) {

                    LazyVGrid(columns: layout) {

                        ForEach(CathalogViewModel.shared.products, id: \.id){ item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }

                    }

                }

            }
        }.navigationBarHidden(true)
        
        
        
    }
}

struct Cathalog_Previews: PreviewProvider {
    static var previews: some View {
        Cathalog()
    }
}
