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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = passedIPictures
        
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
    }
    
    // MARK: - Helpers
    
    func passData(forPic pic: UIImage) {
        self.passedIPictures = pic
    }
    
}
