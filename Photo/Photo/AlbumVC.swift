//
//  ViewController.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//


import SnapKit
import UIKit

class AlbumVC: UIViewController {
    private var viewModel: AlbumViewModelInterface
    private let resultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        return spinner
    }()
    
    init(viewModel: AlbumViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
        resultsTableView.dataSource = self
        resultsTableView.delegate = self

        resultsTableView.register(AlbumTableCell.self, forCellReuseIdentifier:AlbumTableCell.cellIdentifier)
        viewModel.delegate = self
        initialSeach()
    }
    
    private func setupUI() {
        view.addSubview(resultsTableView)
        view.addSubview(activityIndicatorView)
        resultsTableView.snp.makeConstraints {
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
        viewModel.getAlbums()
    }
}

extension AlbumVC: AlbumViewModelDelegate {
    func dataUpdateFailed() {
        hideSpinner()
    }
    
    func dataLoaded() {
        hideSpinner()
        resultsTableView.reloadData()
    }
}

extension AlbumVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.cellIdentifier, for: indexPath) as! AlbumTableCell
        
        if indexPath.row < viewModel.totalCount, let album = viewModel.album(at: indexPath.row) {
            cell.album = album
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.totalCount, let vm = viewModel.album(at: indexPath.row) {
            let dataProvider = AlbumsResult()
            let viewModel = PhotoViewModel(dataProvider: dataProvider, albumId: vm.id)
            let vc = PhotosVC(viewModel: viewModel)
            present(vc, animated: true, completion: nil)
        }
    }
}
