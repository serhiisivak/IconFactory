//
//  FAIconFactory.swift
//  IconFactory
//
//  Created by Sergey Sivak on 19/07/16.
//
//

import FontAwesome_swift

internal class FAIconFactory {
    
    internal class func generate(name iconName: String, size: CGSize, foregroundColor: UIColor = UIColor.whiteColor(), backgroundColor: UIColor = UIColor.clearColor(), completion: (UIImage? -> Void)? = .None) -> UIImage? {
        guard let iconClass = FontAwesomeIcons[iconName] else {
            QIFLogManager.log(.error, message: "icon with name \"\(iconName)\" not found in \(iconsStyle) library")
            return .None
        }
        let icon = FontAwesome(rawValue: iconClass)!
        let image = UIImage.fontAwesomeIconWithName(icon, textColor: foregroundColor, size: size, backgroundColor: backgroundColor)
        
        return image
    }
    
    internal static var availableIconTypes: [String] = FontAwesomeIcons.keys.map{ $0 as String }
}