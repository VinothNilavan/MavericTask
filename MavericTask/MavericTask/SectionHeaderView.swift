//
//  SectionHeaderView.swift
//  MavericTask
//
//  Created by Vinoth on 06/05/21.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier: String = String(describing: self)

    var searchBar : UISearchBar   = {
        let searchBar             = UISearchBar()
        searchBar.searchBarStyle  = UISearchBar.Style.prominent
        searchBar.placeholder     = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent   = false
        searchBar.backgroundImage = UIImage()
        return searchBar

    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
