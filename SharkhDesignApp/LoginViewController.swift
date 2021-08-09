import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adds image "envelope" inside textfield
        let emailIcon = UIImage(systemName: "envelope")
        addLeftImageTo(txtField: email, andImage: emailIcon!)
        
        // adds image "lock" inside textfield
        let passwordIcon = UIImage(systemName: "lock")
        addLeftImageTo(txtField: password, andImage: passwordIcon!)

        // Do any additional setup after loading the view.
    }
    @IBAction func loginbtn(_ sender: Any) {
        validateFields()
    }
    @IBAction func createaccountbtn(_ sender: Any) {
        //takes user to the sign-up viewcontroller when createaccountbtn is tapped
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    // checks if the textfields are filled, if not an alert will pop up
    func validateFields() {
        if email.text?.isEmpty == true {
            print("No Email text")
            let alert = UIAlertController(title: "Alert", message: "Please enter email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if password.text?.isEmpty == true {
            print("No password text")
            let alert = UIAlertController(title: "Alert", message: "Please enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        // if both textfields are filled go to login
        login()
    }
    // checks if there is a user with the same email and password given
    func login() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
            [weak self] authResult, err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
            }
            self!.checkUserInfo()
        }
    }
    // if there is a user the name will be printed and user gets logged in
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        }
    // adds image inside textfield
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        leftImageView.tintColor = .black
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    }


