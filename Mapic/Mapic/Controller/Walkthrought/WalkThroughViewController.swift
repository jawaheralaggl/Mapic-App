//
//  WalkThroughViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/5/20.
//

import UIKit

class WalkThroughViewController: UIViewController, WalkThroughPageViewControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    // MARK: - Properties
    
    var walkthroughPageViewController: WalkThroughPageViewController?
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        updateUI()
    }
    
    // MARK: - Helpers
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("EXPLORE NOW!", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
    
    // MARK: - WalkThroughPageViewController Delegate Method
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkThroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkThroughDelegate = self
        }
    }
    
    
}
