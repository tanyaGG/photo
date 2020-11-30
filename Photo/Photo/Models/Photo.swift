//
//  Photo.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation
struct Photo: Equatable, Decodable, Hashable {
    let albumId: Int
    let title: String
    let thumbnailUrl: URL
}
