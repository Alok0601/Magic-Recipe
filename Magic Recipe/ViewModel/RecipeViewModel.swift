//
//  RecipeViewModel.swift
//  Magic Recipe
//
//  Created by Apple on 12/04/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import Foundation
import UIKit

class recipeViewModel{
    
    static let shared = recipeViewModel()
    var recipes: Recipes?
    
    func searchRecipes(_ ingrediants : String?,_ page: Int,_ complition:@escaping () -> Void){
        
        BaseApi.shared.getTypeURLSession(ingrediants ?? "", nil , page ) { (response, responseCode ) in
            
            let data = (response as! [String:AnyObject])["results"] as! [[String:AnyObject]]
            
            if responseCode == 1{
                
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: (data) , options: .prettyPrinted)
                  
                    let data = try newJSONDecoder().decode(Recipes.self, from: jsonData)
                    
                    if (self.recipes?.count ?? 0) == 0{
                        
                        self.recipes = data
                        
                    }else{
                        self.recipes?.append(contentsOf: data)
                        
                    }
                    
                    complition()
                   
                }catch{
                     self.recipes = []
                    print(error.localizedDescription)
                    complition()
                }
             
                 
                
            }else{
                
                self.recipes = []
                complition()
                
            }
        }
    }
}
