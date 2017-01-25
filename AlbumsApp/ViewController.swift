//
//  ViewController.swift
//  AlbumsApp
//
//  Created by Engylizium on 25.01.17.
//  Copyright © 2017 Sobolev Peresvet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Theme Setup
        menuStack.spacing = view.frame.height * 0.3
        searchButton.layer.borderColor = themeColor.cgColor
        searchButton.layer.borderWidth = 1
        searchButton.layer.cornerRadius = 10
        localAlbumsButton.layer.borderColor = themeColor.cgColor
        localAlbumsButton.layer.borderWidth = 1
        localAlbumsButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var localAlbumsButton: UIButton!
    
    let themeColor = #colorLiteral(red: 0.9996318221, green: 0.9908382297, blue: 0.6350821257, alpha: 1)
    
    @IBAction func localAlbums(_ sender: UIButton) {
        callLocalLib()
    }

    func callLocalLib(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "savedList")
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
    }

}

