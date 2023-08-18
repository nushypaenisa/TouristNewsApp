//
//  TouristCell.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import UIKit

class TouristCell: UITableViewCell {
    
    let profileImageView:UIImageView = {
             let img = UIImageView()
             img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
             img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
             img.layer.cornerRadius = 35
             img.clipsToBounds = true
             img.image = UIImage(systemName: "person")
            return img
         }()
    
    let nameLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            //label.textColor =  .cyan
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    let emailLabel:UILabel = {
            let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
            ///label.textColor =  .cyan
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    let locationLabel:UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 12)
          //label.textColor =  .cyan
          //label.backgroundColor =  .gray
          label.layer.cornerRadius = 5
          label.clipsToBounds = true
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
    }()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
    
    
    override
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(emailLabel)
        self.contentView.addSubview(containerView)
        
        
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:80).isActive = true

        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true

        
        locationLabel.topAnchor.constraint(equalTo:self.emailLabel.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo:self.emailLabel.bottomAnchor).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
