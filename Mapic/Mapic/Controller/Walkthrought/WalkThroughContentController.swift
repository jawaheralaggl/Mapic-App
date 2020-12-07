//
//  WalkThroughContentController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/5/20.
//

import UIKit
import Lottie

class WalkThroughContentController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    // MARK: - Properties
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFiles = ""
    
    var animationView: AnimationView?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation()
        
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
    }
    
    // MARK: - lottieAnimation method
    
    func lottieAnimation() {
        animationView = .init(name: imageFiles)
        animationView?.frame = CGRect(x: 20, y: 100, width: 366, height: 257)
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView!)
        animationView?.play()
    }
    
}
