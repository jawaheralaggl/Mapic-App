//
//  PicturesCell.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/1/20.
//

import UIKit

class PicturesCell: UICollectionViewCell {
    
    // pass data from Model to Controller
    var data: PicturesData? {
        didSet {
            guard let data = data else { return }
            imageView.image = data.image
            distanceLabel.text = data.distance
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        imageView.addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 60).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

