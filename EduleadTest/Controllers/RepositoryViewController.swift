//
//  RepositoryViewController.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    var repository: Repository?
    
    let repositoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let startsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let wachersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        configure()
    }
    
    func setLayout() {
        navigationItem.title = "Repository"
        view.backgroundColor = .white
        let firstView = UIView()
        let secondView = UIView()
        view.addSubview(firstView)
        view.addSubview(secondView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([firstView.topAnchor.constraint(equalTo: view.topAnchor), firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor), firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor), firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5), secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor), secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor), secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor), secondView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        firstView.addSubview(repositoryImage)
        firstView.addSubview(titleLabel)
        NSLayoutConstraint.activate([repositoryImage.centerYAnchor.constraint(equalTo: firstView.centerYAnchor), repositoryImage.centerXAnchor.constraint(equalTo: firstView.centerXAnchor), repositoryImage.heightAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 0.6), repositoryImage.widthAnchor.constraint(equalTo: firstView.heightAnchor, multiplier: 0.6), titleLabel.topAnchor.constraint(equalTo: repositoryImage.bottomAnchor, constant: 20), titleLabel.centerXAnchor.constraint(equalTo: firstView.centerXAnchor)])
        secondView.addSubview(languageLabel)
        let informationStackView = UIStackView(arrangedSubviews: [startsLabel, wachersLabel, forksLabel, issuesLabel])
        informationStackView.alignment = .fill
        informationStackView.axis = .vertical
        informationStackView.distribution = .fillEqually
        informationStackView.spacing = 0
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        secondView.addSubview(informationStackView)
        NSLayoutConstraint.activate([languageLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20), languageLabel.topAnchor.constraint(equalTo: secondView.topAnchor), languageLabel.trailingAnchor.constraint(equalTo: secondView.centerXAnchor, constant: -10), languageLabel.bottomAnchor.constraint(equalTo: secondView.bottomAnchor), informationStackView.leadingAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 10), informationStackView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor,constant: -20), informationStackView.topAnchor.constraint(equalTo: secondView.topAnchor), informationStackView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor)])
    }
    
    func configure() {
        if let repository = repository {
            repositoryImage.loadCacheImage(self, url: repository.image)
            titleLabel.text = repository.fullName
            languageLabel.text = "Development Language: " + repository.language
            startsLabel.text = "\(repository.stars) Stars"
            wachersLabel.text = "\(repository.wachers) Wachers"
            forksLabel.text = "\(repository.forks) Forks"
            issuesLabel.text = "\(repository.issues) Issues"
        }
    }

}
