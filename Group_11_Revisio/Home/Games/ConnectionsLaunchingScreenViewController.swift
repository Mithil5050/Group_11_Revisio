//
//  ConnectionsLaunchingScreenViewController.swift
//  Group_11_Revisio
//
//  Created by Mithil on 15/12/25.
//

import UIKit

class ConnectionsLaunchingScreenViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func StartButton(_ sender: Any) {
        performSegue(withIdentifier: "StartGameConnection", sender: nil)
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
