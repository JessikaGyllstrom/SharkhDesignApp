//
//  ContactViewController.swift
//  Pods
//
//  Created by MadJackChurchill on 2021-08-16.
//
import MessageUI
import UIKit

class ContactViewController: UIViewController, UINavigationControllerDelegate {

    
    //to do, add function if user doent have mail intalled on device
    
    @IBOutlet weak var callbtn: UIButton!
    
    
    let myphone = "+46723372464"
    
    let composeVC = MFMailComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func callbtnClicked(_ sender: Any) {
        guard let number = URL(string: "tel://\(myphone)") else { return }
        UIApplication.shared.open(number)
    }
    @IBAction func emailbtnTapped(_ sender: Any) {
        showMailComposer()
        
    }
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["support@yahoo.com"])
        composer.setSubject("HELP!")
        composer.setMessageBody("nothing...just help!", isHTML: false)
        
        present(composer, animated: true)
        
    }
}
extension UIViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            return
            }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        }
        controller.dismiss(animated: true)
    }
}







    
