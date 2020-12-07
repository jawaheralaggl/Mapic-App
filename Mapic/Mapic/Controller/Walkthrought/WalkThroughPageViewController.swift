//
//  WalkThroughPageViewController.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/5/20.
//

import UIKit

protocol WalkThroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkThroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    weak var walkThroughDelegate: WalkThroughPageViewControllerDelegate?
    
    var pageHeadings = ["WELCOME", "DISCOVER NEW PLACES"]
    var pageSubHeadings = ["Explore the world with Mapic", "Find pictures shared by people around you"]
    var pageImages = ["pin", "friends"]
    
    var currentIndex = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        // create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - PageViewController Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - PageViewController Delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            
            if let contentViewController = pageViewController.viewControllers?.first as? WalkThroughContentController {
                currentIndex = contentViewController.index
                
                walkThroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
    
    // MARK: - Helpers
    
    func contentViewController(at index: Int) -> WalkThroughContentController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // create new view controller and pass the data
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkThroughContentController") as? WalkThroughContentController {
            pageContentViewController.index = index
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.imageFiles = pageImages[index]
            
            return pageContentViewController
        }
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
}
