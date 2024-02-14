//
//  iPad16_3View.swift
//  ZMangas
//
//  Created by Miguel Gallego on 13/2/24.
//

import SwiftUI

enum SideItem: String, CaseIterable {
    case mangas = "Mangas"
    case bestMangas = "Best Mangas"
    case myCollection = "Mi Colección"
    
    var strImg: String {
        switch self {
        case .mangas:  "list.star"
        case .bestMangas:  "star"
        case .myCollection:  "books.vertical"
        }
    }
    
    var view: any View {
        switch self {
        case .mangas:  MangasView()
        case .bestMangas:  BestMangasView()
        case .myCollection:  MyMangasView()
        }
    }
    
    func toolBar(isGridMode: Binding<Bool>) -> some ViewModifier {
        switch self {
        case .mangas:  ToolBarMangas(isGridMode: isGridMode)
        default:   ToolBarMangas(isGridMode: isGridMode)
//        case .bestMangas:  BestMangasView()
//        case .myCollection:  MyMangasView()
        }
    }

}

struct iPad16_3View: View {
    @EnvironmentObject var myMangasVM: MyMangasVM
    @EnvironmentObject var vm: MangasVM
    @EnvironmentObject var searchVM: SearchVM
    @EnvironmentObject var bestMangasVM: BestMangasVM

    @State private var isGridMode = false
    
    @State private var visibility = NavigationSplitViewVisibility.all
    @State private var sideItemSelected: SideItem? = .mangas
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(SideItem.allCases, id: \.self, selection: $sideItemSelected) { item in
                Label(item.rawValue, systemImage: item.strImg)
            }
            .navigationTitle("ZMangas")
            .navigationSplitViewColumnWidth(min: 200, ideal: 200, max: 200)
        } content: {
            Group {
                switch sideItemSelected {
                case .none, .some(.mangas):  MangasView()
                case .some(.bestMangas):  BestMangasView()
                case .some(.myCollection):  MyMangasView()
                }
            }
            .navigationSplitViewColumnWidth(min: 400, ideal: 400, max: 400)
        } detail: {
            switch sideItemSelected {
            case .none, .some(.mangas), .some(.bestMangas):
                if let seletedManga = vm.selectedMangaForIPad {
                    DetailView(manga: seletedManga)
                }
            case .some(.myCollection):  MyMangasView()
            }

        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    iPad16_3View()
        .environmentObject(MangasVM.preview)
        .environmentObject(SearchVM.preview)
        .environmentObject(BestMangasVM.preview)
        .environmentObject(MyMangasVM())
}
