//
//  SearchList.swift
//  AlbumsApp
//
//  Created by Engylizium on 25.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import UIKit

public var searchURL = "http://musicbrainz.org/ws/2/release/?query="

class SearchList: UITableViewController, UISearchBarDelegate {
    // Outlets
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // Actions
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Data
    var data = Data()
    var titles: [String] = []
    var bandNames: [String] = []
    var ID: [String] = []
    let search = UISearchBar()
    
    // JSON Data Extraction
    func exractData(from: Data){
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        let release = json["releases"] as! [Any]
        for info in release {
            let album = info as! [String:Any]
            ID.append(album["id"] as! String)
            titles.append(album["title"] as! String)
            let artistCredit = album["artist-credit"] as! [Any]
            let artistInfo = artistCredit[0] as! [String:Any]
            let artist = artistInfo["artist"] as! [String:Any]
            bandNames.append(artist["name"] as! String)
        }
    }
    
    func loadData(url: URL){
        let utilityQueue = DispatchQueue.global(qos: .utility)
        utilityQueue.async {
            if let jsonData = try? Data(contentsOf: url) {
                self.data = jsonData
                self.exractData(from: self.data)
                self.tableView.reloadData()
            }
        }
        
    }
    
    // Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = search.text!.replacingOccurrences(of: " ", with: "%20")
        searchURL += query
        searchURL += "&fmt=json"
        let url = URL(string: searchURL)!
        titles = []
        bandNames = []
        ID = []
        loadData(url: url)
        
        // Reset URL
        if searchURL.contains("artist:") {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=artist:"
        } else if searchURL.contains("label:") {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=label:"
        } else if searchURL.contains("release:") {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=release:"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBarItem = UIBarButtonItem(customView: search)
        titleBar.rightBarButtonItem = searchBarItem
        search.delegate = self
        search.frame.size = CGSize(width: view.frame.width * 0.75, height: 20)
        tableView.contentInset.top = 20
        titleBar.title = ""
        if searchURL.contains("artist:") {
            search.placeholder = "Search by Artist"
        } else if searchURL.contains("label:") {
            search.placeholder = "Search by Label"
        } else if searchURL.contains("release:") {
            search.placeholder = "Search by Release"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "album", for: indexPath)
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
        isInfoFromLocalLib = false
        self.present(controller, animated: true, completion: nil)
    }
    
}
