//
//  RecipeModel.swift
//  Magic Recipe
//
//  Created by Apple on 12/04/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import Foundation


// MARK: - Result
struct Recipe: Codable {
    let title: String?
    let href: String?
    let ingredients: String?
    let thumbnail: String?
}

typealias Recipes = [Recipe]

