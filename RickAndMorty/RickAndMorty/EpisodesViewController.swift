//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-13.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, Modeling {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var episodes: Episodes?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        title = "Episodes"
        
        self.fetchEpisodes { [weak self] episodes in
            self?.episodes = episodes
            self?.tableView.reloadData()
        }
    }
}

extension EpisodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        episodeCell.textLabel?.text = episodes?.results[indexPath.row].name
        return episodeCell
    }
}
