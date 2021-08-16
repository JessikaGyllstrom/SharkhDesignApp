//
//  GoViewController.swift
//  SharkhDesignApp
//
//  Created by MadJackChurchill on 2021-08-09.
//

import UIKit
import Firebase


class GoViewController: UIViewController {
    
    
    /*struct Person {
        let name, phone, email: String
    }*/

    @IBOutlet weak var hourlbl: UILabel!
    
    let db = Firestore.firestore()

    var user = Auth.auth().currentUser?.uid
    
    
    /*var people = [Person]()
    private var document: [DocumentSnapshot] = []*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentWelcomeMessage()

        
        //creats a reference to firestore
        //adds a collection with data to the firestoredatabase
        db.collection("time").addDocument(data: ["hours":2])
    }

        func presentWelcomeMessage() {
            if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("users")
                let thisUserDoc = collectionRef.document(userId)
                thisUserDoc.getDocument(completion: { document, error in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if let doc = document {
                        let welcomeName = doc.get("first_name") ?? "No Name"
                        let hours = doc.get("hours") ?? "No Hours"
                        let minutes = doc.get("minutes") ?? "No minutes"
                        print("Hey, \(welcomeName) welcome! + \(hours)hours + \(minutes)minutes")
                        self.hourlbl.text = "\(welcomeName)" + "\n" + "\(hours)"

                    }
                })
            }
        }
    }

    
    

