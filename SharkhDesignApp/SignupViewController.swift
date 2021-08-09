//
//  SignupViewController.swift
//  SharkhDesignSupport
//
//  Created by MadJackChurchill on 2021-06-01.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signupbtn(_ sender: Any) {
        // if email textfield is empty an alert will pop up and program returns
        if email.text?.isEmpty == true {
            print("No text in email field")
            let alert = UIAlertController(title: "Alert", message: "Please enter email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            // ADD ALERTVIEW
            return
        }
        // if password textfield is empty an alert will pop up and program returns
        if password.text?.isEmpty == true {
            print("No text in password field")
            let alert = UIAlertController(title: "Alert", message: "Please enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        // if both password and email textfields is filled the signUP function is called
        signUP()
    }
    @IBAction func alreadyaccountbtn(_ sender: Any) {
        //takes user to the sign-in viewcontroller when alreadyaccountbtn is tapped

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func signUP() {
        // calls on firebase to create user with email and password
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
            (authResult, error) in
            // checks if the user is created
            guard let user = authResult?.user, error == nil else {
                print("Error")
                //print("Error \err?.localizedDescription)")

                return
            }
            // if user is created successfully the app will be launched
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        
    }
    
}


