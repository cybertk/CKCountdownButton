# CKCountdownButton

[![CI Status](http://img.shields.io/travis/cybertk/CKCountdownButton.svg?style=flat)](https://travis-ci.org/cybertk/CKCountdownButton)
[![Version](https://img.shields.io/cocoapods/v/CKCountdownButton.svg?style=flat)](http://cocoadocs.org/docsets/CKCountdownButton)
[![License](https://img.shields.io/cocoapods/l/CKCountdownButton.svg?style=flat)](http://cocoadocs.org/docsets/CKCountdownButton)
[![Platform](https://img.shields.io/cocoapods/p/CKCountdownButton.svg?style=flat)](http://cocoadocs.org/docsets/CKCountdownButton)

## Features

* Button is disabled when counting
* Button is auto enabled when counted down
* Click on button can auto start counting
* Set customized background color while counting

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Or run `pod try CKCountdownButton` for latest stable version.


## Requirements

## Installation

CKCountdownButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "CKCountdownButton"

## Usage

### Use in Storyboard

- Drag a UIButton from Object Library
- Set the class of UIBUtton to `CKCountdownButton`. 
- Change the type of UIButton to `Custom`, or it will flash while counting down.
- Set `count` in **User Defined Runtime Attributes** window.
- Set `startCountWhenClick` in **User Defined Runtime Attributes** window if you want start counting when user click the button
 
## Author

Quanlong He, kyan.ql.he@gmail.com
[Tomasz Szulc](https://github.com/tomkowz)

## License

CKCountdownButton is available under the MIT license. See the LICENSE file for more info.
