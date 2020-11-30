//
//  AlbumViewModel.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation


protocol AlbumViewModelDelegate: class {
    func dataLoaded()
    func dataUpdateFailed()
}

// MARK: - Interfaces
protocol AlbumViewModelInterface {
    
    func getAlbums()
    var totalCount: Int { get }
    func album(at index: Int) -> Album?
    var delegate: AlbumViewModelDelegate? { get set }
}

class AlbumViewModel: AlbumViewModelInterface {

    private let resultsProvider: AlbumsResult
    private var albums: [Album] = []
    public weak var delegate: AlbumViewModelDelegate?

    var totalCount: Int {
        return albums.count
    }
    init(dataProvider: AlbumsResult) {
        self.resultsProvider = dataProvider
    }
    
    func getAlbums() {
        self.resultsProvider.albums {[weak self] result in
            switch result {
            case let .success(result):
                self?.albums = result
                self?.delegate?.dataLoaded()
            case .failure(_):
                self?.delegate?.dataUpdateFailed()
            }
        }
    }

    func album(at index: Int) -> Album? {
        guard index < albums.count && index >= 0 else {
            return nil
        }
        return albums[index]
    }
        
}
