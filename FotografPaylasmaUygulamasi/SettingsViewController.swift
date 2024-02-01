//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapTiklandi(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            let alert = UIAlertController(title: "Bilgi", message: "Başarıyla çıkış yaptınız.", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { uıalertaction in
                    self.performSegue(withIdentifier: "toViewController", sender: nil)
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            //performSegue(withIdentifier: "toViewController", sender: nil)
            }catch{
                print("hata")
            }
            
        }
        
        
    }

