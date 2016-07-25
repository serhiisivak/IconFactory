//
//  IconsStyle.swift
//  IconFactory
//
//  Created by Sergey Sivak on 19/07/16.
//
//

public enum IconsStyle: CustomStringConvertible {

	case fontAwesome

	public var description: String {
		switch self {
		case .fontAwesome:
			return "Font Awesome"
		}
	}
}