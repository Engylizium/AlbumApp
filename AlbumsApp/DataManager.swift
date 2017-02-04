//
//  DataManager.swift
//  AlbumsApp
//
//  Created by Engylizium on 31.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    
    func context() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func container() -> NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }
    
    func save(ID: String, artist: String, release: String){
        container().performBackgroundTask({_ in
            let entity = NSEntityDescription.entity(forEntityName: "ReleaseInfo", in: self.context())
            let mo = NSManagedObject(entity: entity!, insertInto: self.context())
            mo.setValue(ID, forKey: "releaseID")
            mo.setValue(artist, forKey: "artist")
            mo.setValue(release, forKey: "releaseTitle")
            do { try self.context().save(); print("saved!") } catch let error as NSError  { print("Could not save \(error), \(error.userInfo)") }
        })
        
    }
    
    func load() -> ([String],[String],[String]){
        var release: [String] = []; var artist: [String] = []; var ID: [String] = []
        let fetchRequest: NSFetchRequest<ReleaseInfo> = ReleaseInfo.fetchRequest()
        do {
            let searchResults = try context().fetch(fetchRequest)
            for data in searchResults as [NSManagedObject] {
                ID.append(data.value(forKey: "releaseID") as! String)
                release.append(data.value(forKey: "releaseTitle") as! String)
                artist.append(data.value(forKey: "artist") as! String)
            }
        } catch {
            print("Error with request: \(error)")
        }
        return (ID,artist,release)
    }
    
    
}
