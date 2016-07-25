//
//  IconFactory.swift
//  IconFactory
//
//  Created by Sergey Sivak on 19/07/16.
//
//

import Foundation

internal var iconsStyle: IconsStyle = .fontAwesome

public class IconFactory {
    
	/**
	 setting style of icons

	 - parameter style: style of icons (source) used in application
	 */
	public class func setIconsStyle(style: IconsStyle) {
        iconsStyle = style
	}
    
    /// All icon types that can be used with selected icons style
    public static var availableIconTypes: [String] {
        switch iconsStyle {
        case .fontAwesome:
            return FAIconFactory.availableIconTypes
        }
    }
    
	/**
	 generating image from specified params

	 - parameter iconName:        string representating of icon in current icon type source
	 - parameter size:            size of resulting image
	 - parameter foregroundColor: color of image
	 - parameter backgroundColor: background color of image
	 - parameter completion:      block that returns generated image

	 - returns: generated image
	 */
	public class func generate(name iconName: String, size: CGSize, foregroundColor: UIColor = UIColor.whiteColor(), backgroundColor: UIColor = UIColor.clearColor(), completion: (UIImage? -> Void)? = .None) -> UIImage? {
        let image: UIImage?
        switch iconsStyle {
        case .fontAwesome:
            image = FAIconFactory.generate(name: iconName, size: size, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
        }
        completion?(image)
        
        return image
	}
    
	/**
	 generating square image from specified params

	 - parameter iconName:        string representating of icon in current icon type source
	 - parameter side:            side of resulting squared image
	 - parameter foregroundColor: color of image
	 - parameter backgroundColor: background color of image
	 - parameter completion:      block that returns generated image

	 - returns: generated image
	 */
	public class func generate(name iconName: String, sizeOfSquareWithSide side: CGFloat, foregroundColor: UIColor = UIColor.whiteColor(), backgroundColor: UIColor = UIColor.clearColor(), completion: (UIImage? -> Void)? = .None) -> UIImage? {
        let size = CGSize(width: side, height: side)
		let image = generate(name: iconName, size: size, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
        completion?(image)
        
        return image
	}
}