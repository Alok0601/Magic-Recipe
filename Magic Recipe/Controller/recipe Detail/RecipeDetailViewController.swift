//
//  RecipeDetailViewController.swift
//  Magic Recipe
//
//  Created by icluster2 on 23/05/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import UIKit
import WebKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    
    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Recipe Details"
        
        webview.load(URLRequest(url: URL(string: urlString ?? "")!))
        
        
    }
    
}
