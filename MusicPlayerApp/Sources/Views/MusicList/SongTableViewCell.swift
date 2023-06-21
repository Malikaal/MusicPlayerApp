//
//  SongTableViewCell.swift
//  MusicPlayerApp
//
//  Created by Malik A. Aziz Lubis on 20/06/23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSongCover: UIImageView!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongArtist: UILabel!
    @IBOutlet weak var lblSongAlbum: UILabel!
    @IBOutlet weak var imgSongSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideImageSongSelected()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func hideImageSongSelected() {
        imgSongSelected.isHidden = true
    }
    
    func loadCellData(model: TrackItem) {
        
        // MARK: Assign songName, songArtist, songAlbum, songCoverArt into TableViewCell
        lblSongName.text = model.data.name
        lblSongArtist.text = model.data.artists.items.first?.profile.name
        lblSongAlbum.text = model.data.albumOfTrack.name
        
        // MARK: Load image from URL
        guard let imageUrlString = model.data.albumOfTrack.coverArt.sources.first?.url,
              let imageUrl = URL(string: imageUrlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self.imgSongCover.image = image
            }
        }
        task.resume()
    }
    
}
