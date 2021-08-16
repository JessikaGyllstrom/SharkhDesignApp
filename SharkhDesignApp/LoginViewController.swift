import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
       
        /*let imageV = UIImageView(frame: CGRect(x: 50, y: 100, width: 150, height: 100))
           imageV.center = view.center
           imageV.image = UIImage(named: "logo", in: Bundle(for: type(of: self)), compatibleWith: nil)
           view.addSubview(imageV)*/
        
        
        //UIImageView.animate(withDuration: 2.0, animations: {
            //self.logo




            //self.logo.transform = self.logo.transform.rotated(by: CGFloat.pi)
            //self.logo.transform = self.logo.transform.
    

        
        // call the keyboardwillshow-function when the viewcontroller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name:  UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the keyboardwillshow-function when the viewcontroller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.email.tag = 0
        self.password.tag = 1
        
        self.email.delegate = self
        self.password.delegate = self
        

        
        let emailicon = UIImage(systemName: "envelope")!
        setPaddingWithImage(image: emailicon, textField: (email))
        
        let passwordicon = UIImage(systemName: "lock.circle")!
        setPaddingWithImage(image: passwordicon, textField: (password))
        
    
      /*  // adds image "envelope" inside textfield
        let emailIcon = UIImage(systemName: "envelope")
        addLeftImageTo(txtField: email, andImage: emailIcon!)
        
        // adds image "lock" inside textfield
        let passwordIcon = UIImage(systemName: "lock")
        addLeftImageTo(txtField: password, andImage: passwordIcon!)
        
        func textFieldsShouldReturn(_ textField: UITextField) -> Bool {
            return true
        }*/
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
    // when the "return"-key is pushed it will go to next textfield
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
    }
        return true
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
func setPaddingWithImage(image: UIImage, textField: UITextField){
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    imageView.frame = CGRect(x: 13.0, y: 13.0, width: 24.0, height: 24.0)
    imageView.tintColor = .lightGray

    //For Setting extra padding other than Icon.
    let seperatorView = UIView(frame: CGRect(x: 50, y: 0, width: 10, height: 50))
    view.addSubview(seperatorView)
    textField.leftViewMode = .always
    view.addSubview(imageView)
    textField.leftViewMode = UITextField.ViewMode.always
    textField.leftView = view
}
    /*func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        leftImageView.tintColor = .lightGray
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }*/
    @objc func keyboardWillShow(notification : Notification) {
        guard let keyboardsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 0 - keyboardsize.height
    }
    @objc func keyboardWillHide(notification : Notification) {
        guard let keyboardsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
        self.view.frame.origin.y = 0
    }
            
    }
    


    
    

