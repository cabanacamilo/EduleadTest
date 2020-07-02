//
//  SearchTableViewCell.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    let repositoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        return image
    }()
    
    let repositoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setLayout()
    }
    
    func setLayout() {
        accessoryType = .disclosureIndicator
        separatorInset.left = 80
        addSubview(repositoryImage)
        addSubview(repositoryTitle)
        NSLayoutConstraint.activate([repositoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), repositoryImage.centerYAnchor.constraint(equalTo: centerYAnchor), repositoryImage.heightAnchor.constraint(equalToConstant: 60), repositoryImage.widthAnchor.constraint(equalToConstant: 60), repositoryTitle.leadingAnchor.constraint(equalTo: repositoryImage.trailingAnchor, constant: 10), repositoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), repositoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    func configure(vc: UIViewController, repository: Repository) {
        repositoryTitle.text = repository.fullName
        repositoryImage.loadCacheImage(vc, url: repository.image)
    }

}
