//
//  GoViewController.swift
//  SharkhDesignApp
//
//  Created by MadJackChurchill on 2021-08-09.
//

import UIKit
import Firebase


class GoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //creats a reference to firestore
        let db = Firestore.firestore()
        //adds a collection with data to the firestoredatabase
        db.collection("time").addDocument(data: ["hours":2])

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
