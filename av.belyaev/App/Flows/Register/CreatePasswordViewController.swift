//
//  CreatePasswordViewController.swift
//  av.belyaev
//
//  Created by Артем Б on 31.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    let registerRequestFactory: AuthRequestFactory = RequestFactory().makeAuthRequestFactory()

    var username: String?
    var password: String?
    
    @IBOutlet weak var passwordView: CompositeTextField!
    
    @IBOutlet weak var confirmPasswordView: CompositeTextField!
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        
        let userData = UserData(
            userID: 1,
            userName: username!,
            password: password!,
            email: "test@test.ru",
            gender: "m",
            creditCard: "5555-6666-4444-2222",
            bio: "How do you do"
        )
        
        registerRequestFactory.registration(userData: userData) { response in
            switch response.result {
            case .success(let value):
                print(value)                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    

}
