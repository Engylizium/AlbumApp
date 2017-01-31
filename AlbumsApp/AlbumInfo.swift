//
//  AlbumInfo.swift
//  AlbumsApp
//
//  Created by Engylizium on 25.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//


import UIKit
import CoreData

public var IDtext = ""
public var artistText = ""
public var releaseText = ""
public var isInfoFromLocalLib = false

class AlbumInfo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isInfoFromLocalLib {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
        ID.text! = IDtext
        artistLabel.text! = artistText
        releaseLabel.text! = releaseText
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        dataManager.save(ID: ID.text!, artist: artistLabel.text!, release: releaseLabel.text!)
    }
    
    let dataManager = DataManager()
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!

}
