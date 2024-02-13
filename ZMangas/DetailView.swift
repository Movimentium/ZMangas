//
//  DetailView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 9/2/24.
//

import SwiftUI

struct DetailView: View {
    let manga: Manga
    var dbManga: DBManga?
    @State private var isEditMode = false
    @State private var volumesIHave: Int = 0
    @State private var volumeIamReading: Int = 0
    @State private var isCompleteCollection: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text(manga.title)
                    .font(.title)
                BookCoverView(coverURL: manga.coverURL, mode: .big)
                
                VStack(alignment: .leading) {
                    Text(manga.authorsFullNames)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    VStack(alignment: .leading) {
                        MiniRowDetail(lbl: FilterBy.genre.name, txt: manga.strGenres)
                        MiniRowDetail(lbl: FilterBy.theme.name, txt: manga.strThemes)
                        MiniRowDetail2Columns(lbl1: FilterBy.demographic.name,
                                              txt1: manga.strDemographics,
                                              lbl2: "Volúmenes", 
                                              txt2: manga.strVolumes)
                        MiniRowDetail2Columns(lbl1: "Fecha inicio",
                                              txt1: manga.strStartDate,
                                              lbl2: "Capítulos",
                                              txt2: manga.strChapters)
                        MiniRowDetail2Columns(lbl1: "Fecha fin",
                                              txt1: manga.strEndDate,
                                              lbl2: "Score",
                                              txt2: manga.score)
                        MiniRowDetail(lbl: "Estado", txt: manga.status)
                    }
                    .padding(.bottom, 4)
                    
                    if dbManga != nil  {
                        Group {
                            let rangeVols = 0...(manga.volumes ?? 100)
                            Stepper(value: $volumesIHave, in: rangeVols) {
                                Text("Volumenes que tengo: \(volumesIHave)")
                            }
                            let rangeReadind = 0...volumesIHave
                            Stepper(value: $volumeIamReading, in: rangeReadind) {
                                Text("Volumen por el que voy: \(volumeIamReading)")
                            }
                            Toggle(isOn: $isCompleteCollection) {
                                Text("Tengo la colección completa:")
                            }
                        }
                        .disabled(!isEditMode)
                    }
                    
                    if let sypnosis = manga.sypnosis {
                        Text("Sinopsis")
                            .font(.headline)
                        Text(sypnosis)
                            .font(.callout).foregroundStyle(.gray)
                    }
                    if let background = manga.background {
                        Text("Background")
                            .font(.headline).padding(.top, 8)
                        Text(background)
                            .font(.callout).foregroundStyle(.gray)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("manga.title: \(manga.title), manga.id: \(manga.id)")
            if let dbm = dbManga {
                print("dbManga: \(dbm)")
                self.volumesIHave = dbManga!.volumesIHave
                self.volumeIamReading = dbManga!.volumeIamReading
                self.isCompleteCollection = dbManga!.isCompleteCollection
            }

        }
        .toolbar {
            if let dbm = dbManga {
                ToolbarItem(placement: .confirmationAction) {
                    Button(isEditMode ? "Guardar" : "Editar") {
                        if isEditMode {
                            dbm.volumeIamReading = volumeIamReading
                            dbm.isCompleteCollection = isCompleteCollection
                            dbm.volumesIHave = volumesIHave
                        }
                        isEditMode.toggle()
                    }
                }
            }
        }//.toolbar
    }
}
    
#Preview {
    NavigationStack {
        DetailView(manga: .akira)
    }
}


//TODO: Poner en archivo aparte
struct MiniRowDetail: View {
    let lbl: String
    let txt: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(lbl)
                .font(.caption)
                .bold()
            Text(txt)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

struct MiniRowDetail2Columns: View {
    let lbl1: String
    let txt1: String
    let lbl2: String
    let txt2: String
    
    var body: some View {
        HStack {
            MiniRowDetail(lbl: lbl1, txt: txt1)
            Spacer()
            MiniRowDetail(lbl: lbl2, txt: txt2)
        }
    }
}
