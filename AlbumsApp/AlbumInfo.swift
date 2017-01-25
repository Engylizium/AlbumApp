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
        saveInfo(artist: artistLabel.text!, releaseID: ID.text!, releaseTitle: releaseLabel.text!)
    }
    
    // Save Data
    func saveInfo(artist: String, releaseID: String, releaseTitle: String) {
        let context = getContext()
        let entity =  NSEntityDescription.entity(forEntityName: "ReleaseInfo", in: context)
        let lib = NSManagedObject(entity: entity!, insertInto: context)
        lib.setValue(artist, forKey: "artist")
        lib.setValue(releaseID, forKey: "releaseID")
        lib.setValue(releaseTitle, forKey: "releaseTitle")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch { }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!

}
