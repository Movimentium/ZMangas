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
                    VStack(alignment: .center) {
                        BookCoverView(coverURL: manga.coverURL, mode: .grid)
                        Text(manga.title)
                            .font(.headline)
                    }
//                    .border(Color.pink)
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
