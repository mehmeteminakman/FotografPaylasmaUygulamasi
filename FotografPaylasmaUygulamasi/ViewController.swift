//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    self.MesajiGoster(titleInput: "Hata !", messageInput: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func kayıtOlTiklandi(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != ""{
            // Kullanıcı oluştur ve firebase e kaydet
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    self.MesajiGoster(titleInput: "Hata !", messageInput: error!.localizedDescription)
                }else{
                    let alert = UIAlertController(title: "Bilgi", message: "Başarıyla kayıt oldunuz", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { uıalertaction in
                            self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            MesajiGoster(titleInput: "Hata !", messageInput: "Kullanıcı email ve şifrenizi giriniz.")
        }
    }
    
    
    
    func MesajiGoster(titleInput : String , messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

