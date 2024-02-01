//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapTiklandi(_ sender: Any) {
        
        performSegue(withIdentifier: "toViewController", sender: nil)
        
    }
    
    
}
