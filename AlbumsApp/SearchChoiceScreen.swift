//
//  SearchChoiceScreen.swift
//  AlbumsApp
//
//  Created by Engylizium on 25.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import UIKit

class SearchChoiceScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Theme Setup
        searchMenuStack.spacing = view.frame.height * 0.2
        
        // - - Buttons Setup
        buttons = [artistButton, labelButton, releaseButton]
        
        for button in buttons {
        button.layer.borderColor = themeColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        }
    }
    
    // Outlets
    @IBOutlet weak var searchMenuStack: UIStackView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var labelButton: UIButton!
    @IBOutlet weak var releaseButton: UIButton!
    
    var buttons: [UIButton] = []
    let themeColor = #colorLiteral(red: 0.9996318221, green: 0.9908382297, blue: 0.6350821257, alpha: 1)
    
    // Actions
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func artistSearch(_ sender: UIButton) {
        callSearch(by: "A")
    }
    @IBAction func labelSearch(_ sender: UIButton) {
        callSearch(by: "L")
    }
    @IBAction func releaseSearch(_ sender: UIButton) {
        callSearch(by: "R")
    }
    
    func callSearch(by queryName: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "searchList")
        if queryName == "A" {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=artist:"
        } else if queryName == "L" {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=label:"
        } else if queryName == "R" {
            searchURL = "http://musicbrainz.org/ws/2/release/?query=release:"
        }
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
}
