//
//  SongViewModel.swift
//  MusicPlayerApp
//
//  Created by Malik A. Aziz Lubis on 20/06/23.
//

import Foundation
import UIKit

class SongViewModel {
    var songs = [Response]()
    
    //MARK: URL sebagai default jika searchString isEmpty
    let searchSongUrlDefault = "https://spotify23.p.rapidapi.com/search/?q=linkin%20park&type=track&offset=0&limit=10&numberOfTopResults=5"
    
    //MARK: URL yang akan digabungkan dengan searchString
    let searchSongUrl = "https://spotify23.p.rapidapi.com/search/?q="
    let searchSongUrlOptionalParam = "&type=track&offset=0&limit=10&numberOfTopResults=5"
    
    func getSong(searchString: String, completion:@escaping () -> Void) {
        // MARK: Change whitespace with "%20" character
        let urlString = searchString.isEmpty ? searchSongUrlDefault : searchSongUrl + searchString.replacingOccurrences(of: " ", with: "%20") + searchSongUrlOptionalParam
        
        NetworkManager.fetchData(urlString: urlString) { songs, error in
            if let songs {
                self.songs = songs
                completion()
            }
        }
    }
}


