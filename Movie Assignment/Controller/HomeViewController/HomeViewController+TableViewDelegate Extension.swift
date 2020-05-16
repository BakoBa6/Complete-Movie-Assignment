//
//  HomeViewController+TableViewDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            isCategorySelectionTableViewVisible.negate()
            categorySelectionButton.setTitle("All", for: .normal)
            selectedCategory = nil
        }else{
            categorySelectionButton.setTitle(categories[indexPath.row-1].categoryTitle, for: .normal)
            selectedCategory = categories[indexPath.row-1]
        }
        setCategorySelectionTableViewInvisible()
        categoryCollectionView.reloadData()
    }
}
