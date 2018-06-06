//
//  iniciarSesionViewController.swift
//  Snapchat
//
//  Created by Job Cantaro on 5/22/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
            print("Intentamos iniciar sesion")
            if error != nil {
                print("Tenemos el siguiente error: \(error!)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user , error) in
                    print("Intentamos crear un usuario")
                    if error != nil {
                        print("Tenemos el siguiente error: \(error!)")
                    } else {
                        print("El usuario fue creado exitosamente")
                        Database.database().reference().child("usuarios").child((user?.uid)!).child("email").setValue(user?.email)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            } else {
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
}

