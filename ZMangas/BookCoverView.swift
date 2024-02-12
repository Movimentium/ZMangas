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
    
    lazy var w = {
        switch mode {
        case .row:
            80
        case .grid:
            160
        case .big:
            200
        }
    }()
    
    var body: some View {
        AsyncImage(url: coverURL) { cover in
            cover.resizable()
                .scaledToFit()
                .frame(width: mode == .row ? 80 : 160)
        } placeholder: {
            Image(systemName: "a.book.closed.ja")
                .resizable()
                .scaledToFit()
                .frame(width: mode == .row ? 80 : 160)
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
