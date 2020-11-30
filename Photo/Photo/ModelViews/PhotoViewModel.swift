//
//  PhotoViewModel.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation

protocol PhotoViewModelDelegate: class {
    func dataLoaded()
    func dataUpdateFailed()
}

// MARK: - Interfaces
protocol PhotoViewModelInterface {
    
    func getPhotos()
    var totalCount: Int { get }
    func photo(at index: Int) -> Photo?
    var delegate: PhotoViewModelDelegate? { get set }
}

class PhotoViewModel: PhotoViewModelInterface {

    var albumId: Int
    private let resultsProvider: AlbumsResult
    private var photos: [Photo] = []
    public weak var delegate: PhotoViewModelDelegate?

    var totalCount: Int {
        return photos.count
    }
    init(dataProvider: AlbumsResult, albumId: Int) {
        self.resultsProvider = dataProvider
        self.albumId = albumId
    }
    
    func getPhotos() {
        self.resultsProvider.photos(self.albumId) {[weak self] result in
            switch result {
            case let .success(result):
                self?.photos = result
                self?.delegate?.dataLoaded()
            case .failure(_):
                self?.delegate?.dataUpdateFailed()
            }
        }
    }

    func photo(at index: Int) -> Photo? {
        guard index < photos.count && index >= 0 else {
            return nil
        }
        return photos[index]
    }
        
}
