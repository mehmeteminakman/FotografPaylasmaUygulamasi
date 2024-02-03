//
//  FeedViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var emailDizisi = [String]()
    var yorumDizisi = [String]()
    var gorselDizisi = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        firebaseVerileriAl()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailDizisi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        cell.emailLabel.text = emailDizisi[indexPath.row]
        cell.yorumLabel.text = yorumDizisi[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: gorselDizisi[indexPath.row]))
        return cell
    }
    
    
    
    func firebaseVerileriAl(){
        
        
        emailDizisi.removeAll()
        yorumDizisi.removeAll()
        gorselDizisi.removeAll()
        let firebase = Firestore.firestore()
        
        firebase.collection("Post").addSnapshotListener { querysnapshot, error in
            if error != nil{
                self.mesajGoster(title: "Hata !", message: error!.localizedDescription)
            }else{
                if querysnapshot?.isEmpty != true && querysnapshot != nil {
                    for document in querysnapshot!.documents {
                        
                        if let gorsel = document.get("image") as? String{
                            self.gorselDizisi.append(gorsel)
                        }
                        if let email = document.get("email") as? String{
                            self.emailDizisi.append(email)
                        }
                        if let yorum = document.get("yorum") as? String{
                            self.yorumDizisi.append(yorum)
                        }
                        
                        
                    }
                    self.tableView.reloadData()
                    
                }
                
            }
            
            
            
            
            
        }
        
    }
    
    
    
    
    func mesajGoster(title :String,message :String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

   

}
