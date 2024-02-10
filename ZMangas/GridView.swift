//
//  GridView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 10/2/24.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var vm: MangasVM
    
    let gridItem = GridItem(.adaptive(minimum: 150))
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem]) {
                ForEach(vm.mangas) { manga in
                    VStack {
                        AsyncImage(url: manga.coverURL) { cover in
                            cover
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                        } placeholder: {
                            Image(systemName: "book")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                        }
                        .shadow(radius: 8)
                        Text(manga.title)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    GridView()
        .environmentObject(MangasVM.preview)
}
