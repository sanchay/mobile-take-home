//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characterUrls: [String]?
    private var characters: [Character]?
    private var filteredCharacters: [Character]?

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
        title = "Characters"
        loadCharacters()
    }
}

extension CharactersViewController: Modeling {
    
    func loadCharacters() {
        let characterIds = characterUrls?.compactMap { urlString -> String? in
            guard let url = URL(string: urlString) else { return nil }
            return url.lastPathComponent
        }.joined(separator: ",")
        guard let ids = characterIds else { return }
        self.fetchCharacters(characterIds: ids) { [weak self] (characters) in
            self?.characters = characters
            self?.filterCharacters(isAlive: true)
            self?.tableView.reloadData()
        }
    }
}

extension CharactersViewController {
    
    func filterCharacters(isAlive: Bool) {
        filteredCharacters = characters?.filter {
            $0.status == (isAlive ? "Alive" : "Dead")
        }.sorted(by: >)
    }
    
    @IBAction func onUpdateSwitch(_ sender: Any) {
        filterCharacters(isAlive: (sender as! UISwitch).isOn)
        tableView.reloadData()
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = tableView.dequeueReusableCell(withIdentifier: "character_cell", for: indexPath)
        characterCell.textLabel?.text = filteredCharacters?[indexPath.row].name
        characterCell.detailTextLabel?.text = filteredCharacters?[indexPath.row].created
        return characterCell
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_show_character", sender: nil)
    }
}

extension CharactersViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterViewController = segue.destination as! CharacterViewController
        let indexPath = tableView.indexPathForSelectedRow
        guard let row = indexPath?.row, row >= 0, let character = filteredCharacters?[row] else {
            fatalError("Incorrect index path row value")
        }
        characterViewController.character = character
    }
}
