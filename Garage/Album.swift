//
//  Album.swift
//  Garage
//
//  Created by Amjad  on 23/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
class Album {
    
    private(set) var album: String!
    private(set) var year: String!
    
    init(artistAlbum: String, albumYear: String) {
        
        // Add a little extra text to the album information
        self.album = "Album: \n\(artistAlbum)"
        self.year = "Released in: \(albumYear)"
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistAlbumLabel.text = "Let's scan an album!"
        yearLabel.text = ""
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setLabels(_:)), name: "AlbumNotification", object: nil)
    }
    func setLabels(notification: NSNotification){
        
        // Use the data from DataService.swift to initialize the Album.
        let albumInfo = Album(artistAlbum: DataService.dataService.ALBUM_FROM_DISCOGS, albumYear: DataService.dataService.YEAR_FROM_DISCOGS)
        artistAlbumLabel.text = "\(albumInfo.album)"
        yearLabel.text = "\(albumInfo.year)"
    }
    
}
