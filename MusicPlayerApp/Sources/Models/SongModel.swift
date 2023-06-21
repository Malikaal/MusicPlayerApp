//
//  SongModel.swift
//  MusicPlayerApp
//
//  Created by Malik A. Aziz Lubis on 20/06/23.
//

import Foundation
import UIKit

struct Response: Codable {
    let tracks: TrackInfo
}

struct TrackInfo: Codable {
    let items: [TrackItem]
}

struct TrackItem: Codable {
    let data: TrackData
}

struct TrackData: Codable {
    let name: String
    let albumOfTrack: AlbumOfTrack
    let artists: Artists
}

struct AlbumOfTrack: Codable {
    let name: String
    let coverArt: CoverArt
}

struct CoverArt: Codable {
    let sources: [CoverArtSource]
}

struct CoverArtSource: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct Artists: Codable {
    let items: [Artist]
}

struct Artist: Codable {
    let profile: Profile
}

struct Profile: Codable {
    let name: String
}
