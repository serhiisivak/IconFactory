//
//  LogManagerType.swift
//  IconFactory
//
//  Created by Sergey Sivak on 19/07/16.
//
//

import Foundation

internal enum LogManagerType: CustomStringConvertible {
    
    case error
    
    case info
    
    
    var description: String {
        switch self {
        case .error:
            return "Error"
        case .info:
            return "Info"
        }
    }
}

internal class QIFLogManager {
    
    internal class func log(type: LogManagerType, message: String) {
        switch type {
        case .error:
            print(":: IconFactory ~ \(type) :: \n\(message)")
        case .info:
            print(":: IconFactory ~ \(type) :: \n\(message)")
        }
    }
}