//
//  BookCoverView.swift
//  ZMangas
//
//  Created by Miguel Gallego on 10/2/24.
//

import SwiftUI

struct BookCoverView: View {
    let cover: Image
    
    var body: some View {
        cover
            .resizable()
            .scaledToFit()
            .frame(height: 200)
    }
}

#Preview {
    BookCoverView(cover: Image(.akira))
}
