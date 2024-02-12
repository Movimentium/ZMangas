//
//  BookCoverView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 10/2/24.
//

import SwiftUI

struct BookCoverView: View {
    let coverURL: URL?
    let mode: Mode
    private let w: CGFloat
    
    init(coverURL: URL?, mode: Mode) {
        self.coverURL = coverURL
        self.mode = mode
        switch mode {
        case .row:   w = 80
        case .grid:  w = 160
        case .big:   w =  300
        }
    }
    
    var body: some View {
        AsyncImage(url: coverURL) { cover in
            cover.resizable()
                .scaledToFit()
                .frame(width: w)
        } placeholder: {
            Image(systemName: "a.book.closed.ja")
                .resizable()
                .scaledToFit()
                .frame(width: w)
                .fontWeight(.ultraLight)
        }
        .shadow(color: .black.opacity(0.3), 
                radius: mode == .row ? 4 : 8,
                x: 0, y: 0)
    }
    
    enum Mode {
        case row
        case grid
        case big
    }
}

#Preview {
    BookCoverView(coverURL: .akiraCoverURL, mode: .big)
}
