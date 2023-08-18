//
//  NewsCell.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    let containerImageView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
    
    let locationImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 16
        img.clipsToBounds = true
        img.backgroundColor = UIColor(white: 0, alpha: 0.1)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    
    let userImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.backgroundColor = UIColor(white: 0, alpha: 0.1)
        img.clipsToBounds = true
        return img
    }()

    
    let titleLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            return label
    }()
    
    let locationLabel:UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 12)
          //label.textColor =  .cyan
          //label.backgroundColor =  .gray
          //label.layer.cornerRadius = 5
          label.clipsToBounds = true
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
    }()
    
    let userNameLabel:UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 12)
          //label.textColor =  .cyan
          //label.backgroundColor =  .gray
          label.layer.cornerRadius = 5
          label.clipsToBounds = true
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
    }()
    
    let createdAt:UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 12)
          //label.textColor =  .cyan
          //label.backgroundColor =  .gray
          label.layer.cornerRadius = 5
          label.clipsToBounds = true
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
    }()
    
    let commentLabel:UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 12)
          //label.textColor =  .cyan
          //label.backgroundColor =  .gray
          label.layer.cornerRadius = 5
          label.clipsToBounds = true
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       /// addSubview(containerImageView)
//        addSubview(titleLabel)
//        addSubview(locationLabel)
//        addSubview(locationImage)
//        addSubview(userImageView)
//        addSubview(userNameLabel)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(locationImage)
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(createdAt)

       
        //addSubview(createdAt)
       // addSubview(commentLabel)
       
        titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        //titleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 10).isActive = true
//        titleLabel.widthAnchor.constraint(equalToConstant:20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        
//
       
       // titleLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
        
       // titleLabel.bottomAnchor.constraint(equalTo:self.locationLabel.bottomAnchor).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
        
       
        
        userImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
       // userImageView.topAnchor.constraint(equalTo:self.locationLabel.bottomAnchor, constant: 5).isActive = true
        userImageView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
        userImageView.topAnchor.constraint(equalTo:self.locationLabel.bottomAnchor).isActive = true
        
        
        //userNameLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo:self.userImageView.trailingAnchor, constant:10).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        //userNameLabel.heightAnchor.constraint(equalToConstant:80).isActive = true
        userNameLabel.topAnchor.constraint(equalTo:self.locationLabel.bottomAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant:30).isActive = true
//
//        userNameLabel.topAnchor.constraint(equalTo:self.locationLabel.bottomAnchor, constant: 5).isActive = true
//        userNameLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
//        userNameLabel.trailingAnchor.constraint(equalTo:self.userImageView.trailingAnchor).isActive = true
        
        
        locationImage.topAnchor.constraint(equalTo:self.userImageView.bottomAnchor, constant: 5).isActive = true
        locationImage.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        
        
        
//        containerImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//        containerImageView.leadingAnchor.constraint(equalTo:self.locationLabel.trailingAnchor, constant:10).isActive = true
//        containerImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
//        containerImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
//
        
       

       
        
        createdAt.topAnchor.constraint(equalTo:self.locationImage.bottomAnchor).isActive = true
        createdAt.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 10).isActive = true
        createdAt.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
        
//        commentLabel.topAnchor.constraint(equalTo:self.createdAt.bottomAnchor).isActive = true
//        commentLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
//        commentLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
