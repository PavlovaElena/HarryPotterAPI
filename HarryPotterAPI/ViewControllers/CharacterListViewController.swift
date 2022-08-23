//
//  CharacterListViewController.swift
//  HarryPotterAPI
//
//  Created by Елена Павлова on 22.04.2022.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var modeToggle: UISegmentedControl!
    
    var charactersList: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.backgroundColor = .systemGray6
        
        NetworkManager.shared.fetch(from: link) { result in
            switch result {
            case .success(let characters):
                self.charactersList.append(contentsOf: characters)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.character = sender as? Character
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let character = charactersList[indexPath.row]
        
        NetworkManager.shared.fetchImage(from: character.image) { result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(_):
                content.image = UIImage(named: "noImage")
            }
        }
        
        content.text = character.name
        content.secondaryText = character.house
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = charactersList[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: character)
    }
}
