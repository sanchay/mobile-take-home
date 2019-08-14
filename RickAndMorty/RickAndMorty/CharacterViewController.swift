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
    
    var labelStatusOverride: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        guard let character = character else {
            return
        }
        
        lblName.text = character.name
        lblStatus.text = labelStatusOverride ? "Dead" : character.status
        
        self.fetchCharacterImage(urlString: character.image) { [weak self] in
            switch $0 {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
        }
    }
}
