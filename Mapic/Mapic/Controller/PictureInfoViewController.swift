//
//  PictureInfoViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/1/20.
//

import UIKit

class PictureInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var passedIPictures: UIImage!
    var passedTitle: String!
    var passedDistance: String!

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.textColor = .mainColor
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .mainColor
        label.text = "1.0 km"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = passedIPictures
        titleLabel.text = passedTitle
        distanceLabel.text = passedDistance
        
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        
        view.addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
    }
    
    // MARK: - Helpers
    
    func passData(forPic pic: UIImage, forTitle title: String, forDistance distance: String) {
        self.passedIPictures = pic
        self.passedTitle = title
        self.passedDistance = distance
    }
    
}
