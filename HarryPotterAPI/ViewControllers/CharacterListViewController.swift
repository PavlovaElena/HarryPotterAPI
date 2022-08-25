//
//  CharacterListViewController.swift
//  HarryPotterAPI
//
//  Created by Елена Павлова on 22.04.2022.
//

import UIKit

enum Mode: Int {
    case device
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var modeToggle: UISegmentedControl!
    
    var charactersList: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 85
        tableView.backgroundColor = .systemGray6
        
        modeToggle.selectedSegmentIndex = SettingsStorageManager.shared.mode.rawValue
        
        NetworkManager.shared.fetch(from: link) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.charactersList.append(contentsOf: characters)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.character = sender as? Character
    }
    
    @IBAction func changeMode() {
        SettingsStorageManager.shared.mode = Mode(rawValue: modeToggle.selectedSegmentIndex) ?? .device
        view.window?.overrideUserInterfaceStyle = SettingsStorageManager.shared.mode.getUserInterfaceStyle()
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        let character = charactersList[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = charactersList[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: character)
    }
}
