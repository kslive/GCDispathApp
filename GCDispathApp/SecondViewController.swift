//
//  SecondViewController.swift
//  GCDispathApp
//
//  Created by Eugene Kiselev on 14.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageURL: URL?
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.alertLogin()
        }
    }
 
    private func delay(_ delay: Int, closure: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    private func alertLogin() {
        
        let alert = UIAlertController(title: "Зарегестрированны?", message: "Введите логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { userNameTextField in
            userNameTextField.placeholder = "Введите логин"
        }
        alert.addTextField { userPasswordTextField in
            userPasswordTextField.placeholder = "Введите пароль"
            userPasswordTextField.isSecureTextEntry = true
        }
        
        self.present(alert, animated: true)
    }
    
    private func fetchImage() {
        
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            
            guard let url = self.imageURL,
                let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                
                self.image = UIImage(data: imageData)
            }
        }
    }
}
