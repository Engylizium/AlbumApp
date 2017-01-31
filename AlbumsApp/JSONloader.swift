//
//  JSONloader.swift
//  AlbumsApp
//
//  Created by Engylizium on 31.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import Foundation

class JSONloader {
    
    func loadDataFromJSON(url: URL) -> ([String],[String],[String]){
        var titles: [String] = []; var bandNames: [String] = []; var ID: [String] = []
        if let data = try? Data(contentsOf: url) {
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]{
                
                let release = json["releases"] as! [[String:Any]]
                for info in release {
                    ID.append(info["id"] as! String)
                    titles.append(info["title"] as! String)
                    let artistCredit = info["artist-credit"] as! [[String:Any]]
                    let artist = artistCredit[0]["artist"] as! [String:Any]
                    bandNames.append(artist["name"] as! String)
                }
            }
        }
        return (ID, bandNames, titles)
    }
}
