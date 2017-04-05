# Dots

[![CI Status](http://img.shields.io/travis/iAmrSalman/Dots.svg?style=flat)](https://travis-ci.org/iAmrSalman/Dots)
[![Version](https://img.shields.io/cocoapods/v/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)
[![License](https://img.shields.io/cocoapods/l/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)
[![Platform](https://img.shields.io/cocoapods/p/Dots.svg?style=flat)](http://cocoapods.org/pods/Dots)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 10.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

Dots is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Dots"
```

## Usage

### Making a Request

```swift
import Dots

Dots.defualt.request("<URL>") { (dot: Dot) in
    
  print(dot.response) // HTTP URL response
  print(dot.data)     // server data
  print(dot.error)    // Errors from request processing

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

### Request With URL-Encoded Parameters

```swift
let parameters: Parameters = ["foo": "bar"]

// All three of these calls are equivalent
Dots.defualt.request("<URL>", parameters: parameters)

// <URL>?foo=bar
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
