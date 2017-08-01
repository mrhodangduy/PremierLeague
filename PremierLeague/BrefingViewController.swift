//
//  BrefingViewController.swift
//  PremierLeague
//
//  Created by QTS Coder on 8/1/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class BrefingViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    var arrImage = [UIImage]()
    var pageController:UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrImage = [#imageLiteral(resourceName: "s3x-2825-1401_M"),#imageLiteral(resourceName: "a0029036-312_M"),#imageLiteral(resourceName: "s3x-2904-1463_M"),#imageLiteral(resourceName: "a0029260-503_M")]
        
        myScrollView.isPagingEnabled = true
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.delegate = self
        myScrollView.contentSize.width = self.view.frame.width * CGFloat(arrImage.count)
        print(myScrollView.contentSize.width)
        
        for i in 0..<arrImage.count
        {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.myScrollView.frame.width, height: self.myScrollView.frame.height)
            imageView.image = arrImage[i]
            
            self.myScrollView.addSubview(imageView)
            
        }
        
        pageController = UIPageControl(frame: CGRect(x: 0, y: 600, width: self.myScrollView.frame.width, height: 30))
        pageController.numberOfPages = arrImage.count
        pageController.currentPageIndicatorTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        pageController.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(pageController)
        
        let button = UIButton(frame: CGRect(x: self.view.frame.width/2 - self.view.frame.width/8, y: 550, width: self.view.frame.width/4, height: 30))
        button.titleLabel?.text = "Start !"
        button.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.alpha = 0
        
        view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = myScrollView.contentOffset.x / self.myScrollView.frame.width
        pageController.currentPage = Int(page)
        if page == 4
        {
            
        }
    }
    
    
}
