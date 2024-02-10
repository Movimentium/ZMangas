//
//  MangaRowView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 10/2/24.
//

import SwiftUI

struct MangaRowView: View {
    
    let manga: Manga
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                AsyncImage(url: manga.coverURL) { cover in
                    cover.resizable()
                        .scaledToFit()
                        .frame(width: 80)
                } placeholder: {
                    Image(systemName: "a.book.closed.ja")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .fontWeight(.ultraLight)
                }
                .padding(.top, 6)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 0)
              
            }
            VStack(alignment: .leading) {
                Text(manga.title)
                    .font(.headline)
                    .padding(.top, 4)
                Text(manga.authorsFullNames)
                    .font(.caption)
                    .foregroundStyle(.gray)
                if !manga.strGenres.isEmpty {
                    Text(FilterBy.genre.name)
                        .font(.caption)
                        .bold()
                    Text(manga.strGenres)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                if !manga.strThemes.isEmpty {
                    Text(FilterBy.theme.name)
                        .font(.caption)
                        .bold()
                    Text(manga.strThemes)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                if !manga.strDemographics.isEmpty {
                    Text(FilterBy.demographic.name)
                        .font(.caption)
                        .bold()
                    Text(manga.strDemographics)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    MangaRowView(manga: .akira)
}
