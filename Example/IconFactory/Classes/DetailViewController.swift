//
//  DetailViewController.swift
//  IconFactory
//
//  Created by Sergey Sivak on 19/07/16.
//
//

import UIKit
import IconFactory

class DetailViewController: UIViewController {
    
    private var imageView: UIImageView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    internal var style: IconsStyle!
    
    internal var name: String!
    
    internal var fColor: UIColor!
    
    internal var bColor: UIColor!
    
    internal var size: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView?.removeFromSuperview()
        IconFactory.setIconsStyle(style)
        IconFactory.generate(name: name, size: size, foregroundColor: fColor, backgroundColor: bColor) { [weak self] image in
            guard let welf = self else { return }
            welf.imageView = UIImageView()
            welf.imageView?.backgroundColor = UIColor.lightGrayColor()
            welf.imageView?.image = image
            welf.scrollView.addSubview(welf.imageView!)
        }
    }
    
    override func viewDidLayoutSubviews() {
        guard imageView != .None else { return }
        imageView?.frame = CGRect(origin: CGPointZero, size: size)
        scrollView.contentSize = scrollView.bounds.size
        if !scrollView.zooming {
            imageView?.center = CGPoint(x: CGRectGetMidX(scrollView.bounds), y: CGRectGetMidY(scrollView.bounds))
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
