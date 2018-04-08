# Dots

[![CI Status](http://img.shields.io/travis/iAmrSalman/Dots.svg?style=flat)](https://travis-ci.org/iAmrSalman/Dots)
[![Version](https://img.shields.io/cocoapods/v/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)
[![License](https://img.shields.io/cocoapods/l/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)
[![Platform](https://img.shields.io/cocoapods/p/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)

![banner](https://user-images.githubusercontent.com/10261166/38473777-8ec657f2-3b95-11e8-9aa0-a07065d65ce2.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.0+
- Swift 4.0+

## Installation


### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build StorageManager.

To integrate StorageManager into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Dots'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate StorageManager into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "iAmrSalman/Dots" ~> 0.5.0
```

Run `carthage update` to build the framework and drag the built `Dots.framework` into your Xcode project.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but StorageManager does support its use on supported platforms. 

Once you have your Swift package set up, adding StorageManager as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/iAmrSalman/Dots.git", from: "0.5.0")
]
```

## Usage

### Making a Request

```swift
import Dots

Dots.defualt.request("<URL>") { (dot: Dot) in
    
  print(dot.response) // HTTP URL response
  print(dot.data)     // server data
  print(dot.error)    // Errors from request processing
  print(dot.json)     // JSON dictionary [String: Any]

}
```

### HTTP Methods

The `HTTPMethod` enumeration lists the HTTP methods:

```swift
public enum HTTPMethod: String {
  case options = "OPTIONS"
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
  case trace   = "TRACE"
  case connect = "CONNECT"
}
```

These values can be passed as the `method` argument to the `request` Function:

```swift
Dots.defualt.request("<URL>") // method defaults to `.get`
Dots.defualt.request("<URL>", method: .post)
Dots.defualt.request("<URL>", method: .put)
Dots.defualt.request("<URL>", method: .delete)
```

The `request` method parameter defaults to `.get`.

### Parameter Encoding

#### GET Request With URL-Encoded Parameters

```swift
let parameters: Parameters = ["foo": "bar"]

Dots.defualt.request("<URL>", parameters: parameters) // defaults url encoding
Dots.defualt.request("<URL>", parameters: parameters, encoding: .url)

// <URL>?foo=bar
```

#### POST Request With URL-Encoded Parameters

```swift
let parameters: Parameters = [
  "foo": "bar",
  "baz": ["a", 1],
  "qux": [
    "x": 1,
    "y": 2,
    "z": 3
  ]
]

Dots.defualt.request("<URL>", method: .post, parameters: parameters) // defaults url encoding
Dots.defualt.request("<URL>", method: .post, parameters: parameters, encoding: .url)

//httpHeader: Content-Type: application/x-www-form-urlencoded; charset=utf-8

// HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3

```

#### POST Request With JSON-Encoded Parameters

```swift
let parameters: Parameters = [
  "foo": [1,2,3],
  "bar": [
    "baz": "qux"
  ]
]

Dots.defualt.request("<URL>", method: .post, parameters: parameters, encoding: .json)

//HTTP header: Content-Type: application/json

// HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}

```

### HTTP Headers

Adding a custom HTTP header to a `Request` is supported directly in the global `request` method. This makes it easy to attach HTTP headers to a `Request`.

```swift
let headers: HTTPHeaders = [
  "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
  "Accept": "application/json"
]

Dots.defualt.request("<URL>", headers: headers)
```

### Concurrency

Choosing between Asynchronous and Synchronous is supported

```swift
Dots.defualt.request("<URL>", concurrency: .async) // concurrency defaults to `.async`
Dots.defualt.request("<URL>", concurrency: .sync)
```

### Maximum concurrent requests

Customizing Maximum concurrent requests executing simultaneously is supported.

The defualt is checking if device is on cellular connection, maximum concurrent requests is restricted to 2, while Wi-Fi is executing up to 6 simultaneous requests.

```swift
let customDots = Dots(maxConcurrentOperation: <Int>)
customDots.request("<URL>") 
```

### Extensions

#### UIImageView

```swift
imageView.setImage(withURL: "<URL>")
```

## Author

Amr Salman, iamrsalman@gmail.com

## License

Dots is available under the MIT license. See the LICENSE file for more info.
