//
//  HomeViewController.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 02-12-22.
//

import UIKit
import Simple_Networking
import KRProgressHUD
import NotificationBannerSwift

class HomeViewController: UIViewController {
    //MARK: - IBOlutlets
    @IBOutlet weak var tableProducts: UITableView!
    @IBOutlet weak var addProductButton: UIButton!
    
    //MARK: - Propertis
    private let cellId = "ProductsTableViewCell"
    private var dataSource = [ProductsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configuracion boton
        setupBottonAddProduct()
        //configuracion table
        setupUI()
        
        
        
        
    }
    
    // hacer que la vista se recargue
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getProducts()
    }
    
    
    private func setupUI(){
        //asignar   Delegete
        tableProducts.delegate = self
        //asignar dataSourse
        tableProducts.dataSource = self
        //registrar celda
        tableProducts.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getProducts(){
        //indicar carga
        KRProgressHUD.show()
        
        //consumir el servicio
        SN.get(endpoint: Endpoints.getPosts) { [weak self](response: SNResultWithEntity<[ProductsModel], ErrorResponse>) in
            //apagar carga
            KRProgressHUD.dismiss()
            
            switch response{
            case.success(let products):
                //respuesta buena
                self?.dataSource = products.reversed()
                //decirle a la table que recargue
                self?.tableProducts.reloadData()
                
                return
                
            case.error(let error):
                //respuesta mala
                NotificationBanner(title: "Errordos", subtitle: error.localizedDescription, style: .danger).show()
                return
                
            case.errorResult(let entity):
                //respuesta no tan mala
                NotificationBanner(title: "Errortres", subtitle: entity.error, style: .danger).show()
                return
                
                
            }
        }
    }
    // redondear el botton
    private func setupBottonAddProduct(){
        addProductButton.layer.cornerRadius = 20
    }
    
    
    private func deleteProductat(indexPath: IndexPath){
        //indicar carga
        KRProgressHUD.show()
        // obtener id del producto que se va a borrar
        let productId = dataSource[indexPath.row].id
        // preparar el endpoind para borrar
        let endpoint = Endpoints.delete + "1" //String(productId)
        print(endpoint)
        //consumir el servicio para borrar el product
        SN.delete(endpoint: endpoint) { (response: SNResultWithEntity<GeneralResponse, ErrorResponse>)in
            //apagar carga
            KRProgressHUD.dismiss()
            
            switch response{
            case.success:
                //respuesta buena
                //1 borrar el producto del dataSourse
                self.dataSource.remove(at: indexPath.row)
                 //2 borrar la celda de la tabla
                self.tableProducts.deleteRows(at: [indexPath ], with: UITableView.RowAnimation.fade)
                return
                
            case.error(let error):
                //respuesta mala
                NotificationBanner(title: "Error dos", subtitle: error.localizedDescription, style: .danger).show()
                return
                
            case.errorResult(let entity):
                //respuesta no tan mala
                NotificationBanner(title: "Error tres", subtitle: entity.error, style: .danger).show()
                return
                
                
            }
        }

        
        
    }
    
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Borrar") { _, _ in
            // aqui borramos el producto
            self.deleteProductat(indexPath: indexPath)
        }
        return [deleteAction]
    }
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    //numero de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    //configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //castear celda
        if let cell = cell as? ProductsTableViewCell{
            //configurar celda
            cell.setupCellWith(products: dataSource[indexPath.row])
        }
        return cell
    }
}
