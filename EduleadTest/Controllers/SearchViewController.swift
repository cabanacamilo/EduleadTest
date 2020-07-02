//
//  SearchViewController.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let cellID = "SearchCell"
    var repositories = [Repository]()
    let manager = APIManager()
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var searchBarContoller: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "Search on GitHub"
        searchBar.searchBar.searchBarStyle = .prominent
        searchBar.searchBar.searchTextField.backgroundColor = .white
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLayout()
        setTableView()
    }
    
    func setNavigationBar() {
        navigationItem.title = "Search"
        navigationItem.searchController = searchBarContoller
    }
    
    func setLayout() {
        view.backgroundColor = .white
        view.addSubview(searchTableView)
        NSLayoutConstraint.activate([searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor), searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchWord = searchBar.text!
        repositories.removeAll()
        searchTableView.reloadData()
        if searchWord.count != 0 {
            setAPIManager(searchWord: searchWord)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repositories.count == 0 {
            tableView.setEmptyView(message: "Type and search on the navigation bar")
        } else {
            tableView.restore()
        }
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchTableViewCell
        let repository = repositories[indexPath.row]
        cell.configure(vc: self, repository: repository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryController = RepositoryViewController()
        repositoryController.repository = repositories[indexPath.row]
        navigationController?.pushViewController(repositoryController, animated: true)
    }
    
    func setAPIManager(searchWord: String) {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.startAnimating()
        searchTableView.backgroundView = spinner
        manager.downloadRepositories(searchWord: searchWord) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = Alert()
                    alert.errorAlert(self ?? UIViewController(), title: "System", messege: "error: \(error)")
                }
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            }
        }
    }
}
