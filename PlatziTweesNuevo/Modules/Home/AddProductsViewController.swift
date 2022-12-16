//
//  AddProductsViewController.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 04-12-22.
//

import UIKit
import Simple_Networking
import KRProgressHUD
import NotificationBannerSwift


class AddProductsViewController: UIViewController {
    
    // MARK: - @IBAOutlests
    @IBOutlet weak var titleTextFiel: UITextField!
    @IBOutlet weak var priceTextFiel: UITextField!
    @IBOutlet weak var descriptionTextFiel: UITextField!

    
    // MARK: - @IBAction
    
    // boton de publicar
    @IBAction func addProducto(){
        // agregar cuando el usuario de click al boton
        saveProduct()
    }
    //boton de volver
    @IBAction func dismissAction(){
        //volver atras
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    
    // crar producto
    private func saveProduct(){
        
        guard let titleProducto = titleTextFiel.text, !titleProducto.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes especificar titulo del producto", style: .danger).show()
            return
        }
        guard let priceProducto = priceTextFiel.text, !priceProducto.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes especificar precio del producto", style: .danger).show()
            return
        }
        
        guard let descriptionProducto = descriptionTextFiel.text, !descriptionProducto.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes especificar escription del producto", style: .danger).show()
            return
        }
        // crear reques
       let request = ProductsRequest(title: titleProducto, price: Int(priceProducto) ?? 0, productsRequestDescription: descriptionProducto, categoryID: 1, images: ["https://placeimg.com/640/480/any"])
        
        // indiar carga
        KRProgressHUD.show()
        
        // llamar al servicio
        SN.post(endpoint: Endpoints.posts, model: request) { [weak self](response: SNResultWithEntity<ProductsModel, ErrorResponse>) in
            // cerrar carga
            KRProgressHUD.dismiss()
            
            print(response)
            switch response{
            case.success:
                // respuesta buena
               // NotificationBanner(subtitle: "Bienvenido \(user.user.names)", style: .success).show()
                self?.dismiss(animated: true, completion: nil)
    
            case.error(let error):
                NotificationBanner(title: "Error uno", subtitle: error.localizedDescription, style: .danger).show()
                print(error)
                return
                // respuesta mala
                
            case.errorResult(let entity):
                NotificationBanner(title: "Error dos", subtitle: entity.error, style: .danger).show()
                print(entity)
                return
                // respuesta no tan mala
                
            }

            
            //apaga carga
            KRProgressHUD.dismiss()
            
        }
        
    }
}
