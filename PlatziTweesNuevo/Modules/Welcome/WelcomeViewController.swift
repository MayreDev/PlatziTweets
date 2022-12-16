//
//  WelcomeViewController.swift
//  PlatziTweesNuevo
//
//  Created by mayre contreras on 01-12-22.
//

import UIKit

class WelcomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    //MARK: - Private Methods
//hacer un radio del boton que quede redondiado, se hace la funcion aqui y luego se llama en el viewdiload
    private func setupUI(){
        logInButton.layer.cornerRadius = 25
    }

}
