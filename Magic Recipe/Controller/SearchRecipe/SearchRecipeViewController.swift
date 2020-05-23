//
//  SearchRecipeViewController.swift
//  Magic Recipe
//
//  Created by Apple on 12/04/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import UIKit
import Alamofire

class SearchRecipeViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var recipeTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK:- Variables
    var page = 1
    var ingredients = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipeTable.delegate = self
        self.recipeTable.dataSource = self
        self.searchBar.delegate = self
        recipeViewModel.shared.recipes = []
        recipeViewModel.shared.searchRecipes(nil,1){
            DispatchQueue.main.async {
               
                 self.recipeTable.reloadData()
            }
        }
    }
}


extension  SearchRecipeViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.ingredients = (searchBar.text ?? "").replacingOccurrences(of: " ", with: "")
        
        recipeViewModel.shared.searchRecipes(self.ingredients,1){
            DispatchQueue.main.async {
                 self.recipeTable.reloadData()
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recipeViewModel.shared.recipes = []
        self.page = 1
        searchBar.endEditing(true)
        self.recipeTable.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
              
        self.searchBar.resignFirstResponder()
        
    }
}
