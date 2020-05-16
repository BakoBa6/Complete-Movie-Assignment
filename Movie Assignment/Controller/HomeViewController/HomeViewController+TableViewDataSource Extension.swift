//
//  HomeViewController+TableViewDataSource Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categorySellectionTableViewCell = categorySelectionTableView.dequeueReusableCell(withIdentifier: "categorySelectionCell", for: indexPath)
        
        categorySellectionTableViewCell.textLabel!.font = categorySellectionTableViewCell.textLabel!.font.withSize((view.frame.size.height)*categorySelectionTableViewConstant)
        
        if indexPath.row == 0{
            categorySellectionTableViewCell.textLabel!.text = "All"
        }else{
          categorySellectionTableViewCell.textLabel!.text = categories[indexPath.row-1].categoryTitle
        }
        categorySellectionTableViewCell.backgroundColor = #colorLiteral(red: 0.02902549691, green: 0.06305591017, blue: 0.09286930412, alpha: 1)
        categorySellectionTableViewCell.textLabel?.textColor = .white
        return categorySellectionTableViewCell
    }
    
    
}
