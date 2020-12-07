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
    var favPicsArray = [UIImage]()
    
    let shareButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(tappedShare), for: .touchUpInside)
        return btn
    }()
    
    let favouriteButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(tappedFavourite), for: .touchUpInside)
        return btn
    }()
    
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
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // toggle favouriteButton image
        let image = UIImage(named: "star")
        let imageFilled = UIImage(named: "star.fill")
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.setImage(imageFilled, for: .selected)
        
        imageView.image = passedIPictures
        titleLabel.text = passedTitle
        
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        view.addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        
        view.addSubview(shareButton)
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 75).isActive = true
        
        view.addSubview(favouriteButton)
        favouriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favouriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        favouriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        favouriteButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 8).isActive = true
        favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    // MARK: - Selectors
    
    @objc func tappedShare() {
        // picture to share
        let pics = passedIPictures
        
        // set up activity view controller
        let picToShare = [ pics! ]
        let activityViewController = UIActivityViewController(activityItems: picToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToFacebook
        ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    var isChecked = false
    @objc func tappedFavourite() {
        favPicsArray = []
        isChecked = !isChecked
        if isChecked {
            favouriteButton.isSelected.toggle()
            favPicsArray.append(self.passedIPictures)
        }else{
            favouriteButton.isSelected.toggle()
        }
        
    }
    
    // MARK: - Helpers
    
    func passData(forPic pic: UIImage, forTitle title: String) {
        self.passedIPictures = pic
        self.passedTitle = title
    }
    
}
