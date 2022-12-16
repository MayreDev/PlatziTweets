//
//  LoginViewController.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 01-12-22.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import KRProgressHUD

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK: - IBActions
    //hacer la accion de boton
    @IBAction func logInButtonAction(){
        //ocultar teclado al dar ok
        view.endEditing(true)
        performLogin()
      
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    //MARK: - Private Methods
    //hacer un radio del boton que quede redondiado, se hace la funcion aqui y luego se llama en el viewdiload
    private func setupUI(){
            logInButton.layer.cornerRadius = 25
        emailTextField.text = "john@mail.com"
        passwordTextField.text = "changeme"
        }
    
    private func performLogin(){
        guard let email = emailTextField.text, !email.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo", style: .warning).show()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else{
            NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña", style: .danger).show()
            return
        }
         
        //indicar carga
        KRProgressHUD.show()

        // llamar a la libreria
        SN.get(endpoint: Endpoints.login) { [weak self](response: SNResultWithEntity<[User], ErrorResponse>) in
            //apaga carga
            KRProgressHUD.dismiss()
            

            switch response{
            case.success(let users):
                // respuesta buena
               // NotificationBanner(subtitle: "Bienvenido \(user.user.names)", style: .success).show()
                var foundUser = false
                for user in users{
                    if email == user.email && password == user.password{
                        NotificationBanner(subtitle: "Bienvenido \(user.name)", style: .success).show()
                        //pasar a la pantalla del home
                        self?.performSegue(withIdentifier: "showHome", sender: nil)
                        foundUser = true
                        break
                    }
                }
                if !foundUser {
                    NotificationBanner(title: "Error", subtitle:"No se encontro usuario ni contraseña", style: .danger).show()
                }
            case.error(let error):
                NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger).show()
                return
                // respuesta mala
                
            case.errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: entity.error, style: .danger).show()
                return
                // respuesta no tan mala
                
            }

        }
        
        
        
    }
  
   
}
