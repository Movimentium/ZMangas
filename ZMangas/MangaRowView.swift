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
        NavigationLink(value: manga) {
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
        .overlay(alignment: .bottomTrailing) {
            HStack(spacing: 4) {
                Text(manga.score)
                    .font(.callout)
                Image(systemName: "star.fill")
                    .font(.caption)
            }
            .foregroundStyle(.cyan)
        }
    }
}


#Preview {
    MangaRowView(manga: .akira)
        .border(Color.pink)
}
