#IconFactory

[![CI Status](http://img.shields.io/travis/Sergey Sivak/IconFactory.svg?style=flat)](https://travis-ci.org/Sergey Sivak/IconFactory)
[![Version](https://img.shields.io/cocoapods/v/IconFactory.svg?style=flat)](http://cocoapods.org/pods/IconFactory)
[![License](https://img.shields.io/cocoapods/l/IconFactory.svg?style=flat)](http://cocoapods.org/pods/IconFactory)
[![Platform](https://img.shields.io/cocoapods/p/IconFactory.svg?style=flat)](http://cocoapods.org/pods/IconFactory)

##Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

##Requirements

iOS >= 8.0
FontAwesome.swift

##Installation

IconFactory is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "IconFactory"
```
##Usage
###Specify your icons style
for now only fontAwesome style is supported. It's used by-default

```swift
let style: IconsStyle = .fontAwesome
IconFactory.setIconsStyle(style)
```

###General usage

```swift
let icon = IconFactory.generate(name: "fa-facebook", size: CGSize(width: 10, height: 50), foregroundColor: UIColor.redColor(), backgroundColor: UIColor.blackColor())
```

###Simple usage

You can use only name and size parameters. Default value of foregroundColor is 'white' and backgroundColor is 'clear'.

```swift
let icon = IconFactory.generate(name: "fa-facebook", size: CGSize(width: 10, height: 50))
```

###Using squared icons

to use icons of squared size you can specify only one side of icon and use

```swift
let icon = IconFactory.generate(name: "fa-facebook", sizeOfSquareWithSide: 44)
```

###Using completion block

you can generate icon and return it in completion

```swift
IconFactory.generate(name: "fa-facebook", sizeOfSquareWithSide: 44, completion: { icon in ... })
```

```swift
IconFactory.generate(name: "fa-facebook", sizeOfSquareWithSide: 44) { icon in ... }
```

##Author

Sergey Sivak

##License

IconFactory is available under the MIT license. See the LICENSE file for more info.
