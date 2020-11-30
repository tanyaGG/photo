//
//  PhotoCell.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//
import SDWebImage
import Foundation
import UIKit
import SnapKit

class PhotoCell: UICollectionViewCell {
    static let cellIdentifier = "Cell"
    let iv = UIImageView()
    var photo:Photo? {
        didSet {
            if let photo = photo {
                iv.sd_setImage(with: photo.thumbnailUrl, placeholderImage: nil)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(iv)
        iv.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        backgroundColor = .white
    }
}
