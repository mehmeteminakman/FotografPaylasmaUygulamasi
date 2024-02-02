//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        uploadButton.isEnabled = false
        uploadButton.backgroundColor = .lightGray
        
    }
    
    @objc func  gorselSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        uploadButton.isEnabled = true
        uploadButton.backgroundColor = .systemIndigo
    }
    
    @IBAction func uploadButtonTiklandi(_ sender: Any) {
        print("UPLOAD TİKLANDİ")
        let uuid = UUID().uuidString // uuid oluşturmamızın amacı firebase de aynı isimli dosyalarda override olur  (veri kaybı)
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("Media") // firebase de Media adlı klasör oluşturuldu
        
        let image = imageView.image!.jpegData(compressionQuality: 0.5) // kullanıcı image alındı data cast işlemi yapıldı
        let imageRef = mediaFolder.child("\(uuid).jpg")
         imageRef.putData(image!) { storagemetadata, error in
            if error != nil{
                self.mesajGoster(title: "Hata !", message: error!.localizedDescription)
            }else{
                imageRef.downloadURL { url, error in
                    if error == nil{
                        
                        let urlString = url?.absoluteString
                        let firestoreDatabase = Firestore.firestore()
                        if let urlString = urlString{
                            let data = ["email": Auth.auth().currentUser!.email! , "image" : urlString , "yorum":self.yorumTextField.text!, "tarih":FieldValue.serverTimestamp()] as! [String : Any]
                            firestoreDatabase.collection("Post").addDocument(data: data) { error in
                                if error == nil {
                                    let alert = UIAlertController(title: "Bilgi", message: "Görseliniz başarılı bir şekilde post edildi", preferredStyle: UIAlertController.Style.alert)
                                    let okButton = UIAlertAction(title: "OK" , style: UIAlertAction.Style.default) { uıalertaction in
                                        self.imageView.image = UIImage(named: "image")
                                        self.yorumTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                    alert.addAction(okButton)
                                    self.present(alert, animated: true)
                                    
                                }else{
                                    self.mesajGoster(title: "Hata !", message: error!.localizedDescription)
                                }
                            }
                        }
                        
                        
                        
                    }
                    
                }
                
                
                
                
                
                }
            }
        }
    
    
    func mesajGoster(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK" , style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    
}


