# UTF8Decoder

## Features

This module provides a function to read one character as UTF-8 data 
from the serialized data at one time.

## USAGE

1. Reads one character as UTF-8 data which is composed of UInt8 
   from the serialized data.

```
let ppap = ["✑", "🍍", "🍎", "✑"]
let str = ppap.joined()
let strRawData: Data = strArr.data(using: .utf8)!

var utf8decoder = UTF8Decoder(buffer: strRawData)

// reads one character as [UInt8] from the serialized data.
while let uint8Arr = utf8decoder.read() {
    let char = String(data: Data(bytes: uint8Arr), encoding: .utf8)
    print(char, terminator: " ")
}
//✑ 🍍 🍎 ✑ 
```

2. Buffers data and output the UTF-8 data as soon as completed.

```
let ppap = ["✑", "🍍", "🍎", "✑"]
let str = ppap.joined()
let strRawData: Data = strArr.data(using: .utf8)!

var utf8decoder = UTF8Decoder()

for byte in strRawData {

    // buffering
    utf8decoder.append(buffer: byte)

    while let uint8arr = utf8decoder.read() {
        let char = String(data: Data(bytes: uint8Arr), encoding: .utf8)
        print(char, terminator: " ")
    }
    //✑ 🍍 🍎 ✑ 
}
```

## INSTALL

This module use Swift Package Manger.
You add the following into dependencies.

```
.Package(url: "https://github.com/ysn551/UTF8Decoder", "0.0.1")
```

## LICENSE

[BSD LICENSE](https://opensource.org/licenses/bsd-license.php)

-----------
[@ysn551](https://twitter.com/ysn551),　January 4,2017
