//
//  KilledCharacter.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import Foundation

let kKilledCharacters = "killed_characters"

struct Killed {
    typealias DictOfArrays = Dictionary<String, Array<Int>>
    var characters: DictOfArrays
    private let userDefaults = UserDefaults.standard
    
    init() {
        //restore killed characters
        characters = (userDefaults.dictionary(forKey: kKilledCharacters) ?? DictOfArrays()) as! Killed.DictOfArrays
    }
    
    mutating func add(episodeId: Int, characterId: Int) {
        let key = "\(episodeId)"
        var val = characters[key] ?? Array<Int>()
        val.append(characterId)
        characters.updateValue(val, forKey: key)
        userDefaults.setValue(characters, forKeyPath: kKilledCharacters)
        userDefaults.synchronize()
    }
}
