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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configure() {
        title = "Episodes"
        
        self.fetchEpisodes { [weak self] episodesResult in
            switch episodesResult {
            case .success(let episodes):
                self?.episodes = episodes
                self?.tableView.reloadData()
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
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

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue_show_characters", sender: nil)
    }
}

extension EpisodesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let charactersViewController = segue.destination as! CharactersViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        guard let row = indexPath?.row, row >= 0 else {
            fatalError("Incorrect index path row value")
        }
        let characterUrls = episodes?.results[row].characters
        charactersViewController.characterUrls = characterUrls
    }
}
