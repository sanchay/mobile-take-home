//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, Modeling {
    
    var character: Character?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        guard let character = character else {
            return
        }
        
        lblName.text = character.name
        lblStatus.text = character.status
        
        self.fetchCharacterImage(urlString: character.image) { [weak self] in
            self?.imageView.image = $0
        }
    }
}
