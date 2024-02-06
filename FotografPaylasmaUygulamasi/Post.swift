//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by mehmet emin akman on 6.02.2024.
//

import Foundation



class Post{
    
    var gorselUrl : String
    var email :String
    var yorum : String
    
    init(gorselUrl: String , email: String, yorum: String) {
        self.gorselUrl = gorselUrl
        self.email = email
        self.yorum = yorum
    }
}
