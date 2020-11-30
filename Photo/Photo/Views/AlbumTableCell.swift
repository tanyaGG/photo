//
//  AlbumTableCell.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation
import UIKit
import SnapKit

class AlbumTableCell: UITableViewCell {
    
    struct Constants {
        static let left: CGFloat = 20.0
        static let right: CGFloat = 60.0
        static let top: CGFloat = 20.0
        static let bottom: CGFloat = 20.0
    }

    static let cellIdentifier = "Cell"
    let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    var album:Album? {
        didSet {
            if let album = album {
                label.text = album.title
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    private func configureUI() {
        accessoryType = .disclosureIndicator
        addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalTo(self).inset(UIEdgeInsets(top: Constants.top,
                                                      left: Constants.left,
                                                      bottom: Constants.bottom,
                                                      right:Constants.right))
        }
        backgroundColor = .white
    }
}
