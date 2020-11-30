//
//  PhotosVC.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation
import UIKit
import SnapKit


class PhotosVC: UIViewController {
    struct Constants {
        static let padding: CGFloat = 50.0
        static let horizontalPadding: CGFloat = 10.0
        static let columns:CGFloat = 4
    }

    private var viewModel: PhotoViewModelInterface
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constants.padding,
                                           left: Constants.horizontalPadding,
                                           bottom: Constants.padding,
                                           right: Constants.horizontalPadding)
        let tableView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        return spinner
    }()
    
    init(viewModel: PhotoViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellIdentifier)
        viewModel.delegate = self
        initialSeach()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalTo(view)
        }
    }
    
    private func showSpinner() {
        activityIndicatorView.startAnimating()
    }
    
    private func hideSpinner() {
        activityIndicatorView.stopAnimating()
    }
    
    private func initialSeach() {
        showSpinner()
        viewModel.getPhotos()
    }
}

extension PhotosVC: PhotoViewModelDelegate {
    func dataUpdateFailed() {
        hideSpinner()
    }
    
    func dataLoaded() {
        hideSpinner()
        collectionView.reloadData()
    }
}

extension PhotosVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - Constants.padding
        
        return CGSize(width: collectionViewSize/Constants.columns, height: collectionViewSize/Constants.columns)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellIdentifier, for: indexPath) as! PhotoCell
        
        if indexPath.row < viewModel.totalCount, let photo = viewModel.photo(at: indexPath.row) {
            cell.photo = photo
        }
        return cell
    }
}
