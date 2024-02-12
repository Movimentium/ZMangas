//
//  MyMangasVM.swift
//  ZMangas
//
//  Created by Miguel Gallego on 12/2/24.
//

import Foundation

final class MyMangasVM: ObservableObject {
    let interactor: DataInteractor
    
    init(interactor: DataInteractor = Network()) {
        self.interactor = interactor
        
    }
    
    private var setIds: Set<Int> = [1, 2, 3] {
        didSet {
            print(setIds)
        }
    }
    
    func isInMyDB(id: Int) -> Bool {
        setIds.contains(id)
    }
    
    func getMisMasgas() {
        
    }
    
    func addManga(_ manga: Manga) {
        setIds.insert(manga.id)
        objectWillChange.send()
    }
    //  add manga
    
    // delete manga
    
    
    
}
