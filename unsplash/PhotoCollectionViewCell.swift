//
//  PhotoCollectionViewCell.swift
//  unsplash
//
//  Created by Hy Horng on 11/4/20.
//  Copyright © 2020 Hy Horng. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var bgImage: UIImageView?
    var bgView: UIView?
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImage = UIImageView(frame: frame)
//        //customise imageview
        bgImage?.backgroundColor = UIColor.green
        bgImage?.image = UIImage(named: "g3")
        bgImage?.layer.cornerRadius = 10
        contentView.addSubview(bgImage!)
        
        bgImage?.translatesAutoresizingMaskIntoConstraints = false
        bgImage?.clipsToBounds = true
        bgImage?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        bgImage?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        bgImage?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        bgImage?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        //set ui view color
        bgView = UIView(frame: frame)
        bgView?.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        bgView?.layer.cornerRadius = 10
        contentView.addSubview(bgView!)
        
        //set constraint ui view
        bgView?.translatesAutoresizingMaskIntoConstraints = false
        bgView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        bgView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        bgView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        bgView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        label = UILabel(frame: frame)
        //Customsize label
        label?.textColor = UIColor.white
        label?.textAlignment = .center
        label?.numberOfLines = 0
        contentView.addSubview(label!)
        
        //set constraint ui label
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        label?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        label?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        label?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
}
