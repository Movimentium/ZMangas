//
//  MyMangasView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct MyMangasView: View {
    @EnvironmentObject var vm: MyMangasVM

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.myMangas) { myManga in
                    NavigationLink(value: myManga) {
                        let manga = myManga.manga
                        let dbManga = myManga.dbManga
                        HStack(alignment: .top) {
                            VStack(alignment: .center) {
                                BookCoverView(coverURL: manga.coverURL, mode: .row)
                                    .padding(.top, 6)
                            }
                            VStack(alignment: .leading) {
                                Text(manga.title)
                                    .font(.headline)
                                    .padding(.top, 4)
                                Text(manga.authorsFullNames)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                HStack {
                                    Text("Volúmenes que tengo")
                                        .font(.subheadline)
                                    Text("\(dbManga.volumesIHave)")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("Volumen por el que voy")
                                        .font(.subheadline)
                                    Text("\(dbManga.volumeIamReading)")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                                Text("\(dbManga.isCompleteCollection ? "" : "NO ")Tengo la colección completa")
                                    .font(.subheadline)                                        
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .modifier(SelectMyMangaForIPadModifier(myManga: myManga))
                    .swipeActions {
                        Button {
                            withAnimation {
                                vm.deleteManga(myManga)
                            }
                        } label: {
                            Label("Borrar", systemImage: "trash")
                        }
                        .tint(.red)
                    }

                }
            }
            .navigationTitle("Mis Mangas")
            .navigationBarTitleDisplayMode(.inline)
            .modifier(NavDestinationModifier(sideItem: .myCollection))
        } //NavStack
    }
}

#Preview {
    MyMangasView()
        .environmentObject(MyMangasVM())
}
