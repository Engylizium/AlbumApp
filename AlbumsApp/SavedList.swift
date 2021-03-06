//
//  SavedList.swift
//  AlbumsApp
//
//  Created by Engylizium on 25.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import UIKit
import CoreData

class SavedList: UITableViewController {
    
    // Data
    let dataManager = DataManager()
    var titles: [String] = []
    var bandNames: [String] = []
    var ID: [String] = []

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 20
        (ID, bandNames, titles) = dataManager.load()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "local", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = bandNames[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Info")
        controller.modalTransitionStyle = .crossDissolve
        IDtext = ID[indexPath.row]
        releaseText = titles[indexPath.row]
        artistText = bandNames[indexPath.row]
        isInfoFromLocalLib = true
        self.present(controller, animated: true, completion: nil)
    }

}
