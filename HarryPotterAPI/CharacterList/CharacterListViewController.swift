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
    
    private var viewModel: CharacterListViewModelProtocol! {
        didSet {
            viewModel.fetchCharacters {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterListViewModel()
        
        tableView.rowHeight = 85
        tableView.backgroundColor = .systemGray6
        
        modeToggle.selectedSegmentIndex = SettingsStorageManager.shared.mode.rawValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CharacterDetailsViewController else { return }
        detailsVC.viewModel = sender as? CharacterDetailsViewModelProtocol
    }
    
    @IBAction func changeMode() {
        SettingsStorageManager.shared.mode = Mode(rawValue: modeToggle.selectedSegmentIndex) ?? .device
        view.window?.overrideUserInterfaceStyle = SettingsStorageManager.shared.mode.getUserInterfaceStyle()
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVM = viewModel.detailsViewModel(at: indexPath)
        performSegue(withIdentifier: "showDetails", sender: detailsVM)
    }
}


