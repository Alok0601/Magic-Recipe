//
//  recipe- DataSource + Delegate.swift
//  Magic Recipe
//
//  Created by icluster2 on 22/05/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import WebKit

extension SearchRecipeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipeViewModel.shared.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.recipeTable.dequeueReusableCell(withIdentifier: "RecipeTableViewCell") as! RecipeTableViewCell
        
        cell.recipe_lbl.text = recipeViewModel.shared.recipes?[indexPath.row].title ?? ""
        cell.ingredient_lbl.text = recipeViewModel.shared.recipes?[indexPath.row].ingredients ?? ""
        cell.img.sd_setImage(with: URL(string: recipeViewModel.shared.recipes?[indexPath.row].thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImg"))
        return cell
        
    }
    
}





extension SearchRecipeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        vc.urlString = recipeViewModel.shared.recipes?[indexPath.row].href ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastElement = (recipeViewModel.shared.recipes?.count ?? 0) - 1
        if indexPath.row == lastElement {

            recipeViewModel.shared.searchRecipes(nil,self.page + 1) {
                DispatchQueue.main.async {
                     self.recipeTable.reloadData()
                }
            }
        }
    }
}
