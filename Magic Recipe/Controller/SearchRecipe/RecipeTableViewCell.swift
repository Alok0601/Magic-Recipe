//
//  RecipeTableViewCell.swift
//  Magic Recipe
//
//  Created by icluster2 on 22/05/20.
//  Copyright © 2020 Alok Ranjan. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    //MARK- Outlets
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var recipe_lbl: UILabel!
    @IBOutlet weak var ingredient_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
