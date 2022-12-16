//
//  RegisterViewController.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 01-12-22.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import KRProgressHUD

class RegisterViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var namesTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

//MARK: - IBAction
    @IBAction func registerButtonAction(){
        //ocultar teclado al dar ok
        view.endEditing(true)
        performRegister()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    //MARK: - Private Methods
    //hacer un radio del boton que quede redondiado, se hace la funcion aqui y luego se llama en el viewdiload
    private func setupUI(){
            registerButton.layer.cornerRadius = 25
        }
    private func performRegister(){
        guard let names = namesTextField.text, !names.isEmpty else{
            let notif =  NotificationBanner(title: "Error", subtitle: "Debes ingresar Nombre y Apellido", style: .danger,colors: CustomBanner())
            notif.show()
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes ingresar un correo", style: .danger).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes ingresar una contraseña", style: .danger).show()
            return
        }
        let avatardefault = "https://api.lorem.space/image/face?w=640&h=480&r=2470"
        //crear request
        let request = RegisterRequest(name: names, email: email, password: password, avatar: avatardefault)
        //generar carga
        KRProgressHUD.show()
        //llamar al servicio
        SN.post(endpoint: Endpoints.register, model: request) { [weak self](response: SNResultWithEntity<User, ErrorResponse>) in
            //apaga carga
            KRProgressHUD.dismiss()
            switch response{
            case.success(let user):
                //respuesta buena
                self?.performSegue(withIdentifier: "showHome", sender: nil)
                
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
        
        
        
        
        
        
        //performSegue(withIdentifier: "showHome", sender: nil)

    }
    

}
