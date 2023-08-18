//
//  ViewTouristViewController.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import UIKit

class ViewTouristViewController: UIViewController {
    
    var tourist: Tourist = Tourist()
    
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.layer.cornerRadius = 16
       imageView.layer.masksToBounds = true
       imageView.backgroundColor = UIColor(white: 0, alpha: 0.1)
       return imageView
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Firmal"
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "ptdqrdqwe@gmail.com"
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    private let touristLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dagoretti"
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        view.addSubview(profileImageView)
           profileImageView.translatesAutoresizingMaskIntoConstraints = false
           profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
           profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
           profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
      
        
        view.addSubview(nameLabel)
        nameLabel.text = "Tourist Name: \(tourist.touristName ?? "")"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -30).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        nameLabel.topAnchor.constraint(equalTo:profileImageView.bottomAnchor, constant: 60).isActive = true
        
        
        view.addSubview(emailLabel)
        emailLabel.text = "Tourist Email: \(tourist.touristEmail ?? "")"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 10).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -30).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        emailLabel.topAnchor.constraint(equalTo:profileImageView.bottomAnchor, constant: 40).isActive = true
        
        
        view.addSubview(touristLocationLabel)
        touristLocationLabel.text = "Tourist Location: \(tourist.touristLocation ?? "")"
        touristLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        touristLocationLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 10).isActive = true
        touristLocationLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -30).isActive = true
        touristLocationLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        touristLocationLabel.topAnchor.constraint(equalTo:profileImageView.bottomAnchor, constant: 20).isActive = true
        
        
      

        // Do any additional setup after loading the view.
    }
    
}
