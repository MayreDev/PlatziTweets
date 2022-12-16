//
//  ProductsTableViewCell.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import UIKit
import Kingfisher

class ProductsTableViewCell: UITableViewCell {
    //MARK: - iboultlets
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }


        func setupCellWith(products: ProductsModel){
            productLabel.text = products.title
            priceProductLabel.text = "Price: $\(products.price)"
            descriptionProductLabel.text = "Descrition of product: \n\(products.productsModelDescription)"
            if !products.images.isEmpty{
                imageProduct.kf.setImage(with: URL(string: products.images[0]))
                imageProduct.layer.cornerRadius = 50
            }else{
                imageProduct.isHidden = true
            }
            
        }
    
    
}
