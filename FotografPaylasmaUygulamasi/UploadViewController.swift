//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 1.02.2024.
//

import UIKit

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
    }
    
    

}
