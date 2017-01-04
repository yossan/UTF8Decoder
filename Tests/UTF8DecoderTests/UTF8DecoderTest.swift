import XCTest
@testable import UTF8Decoder

class UTF8DecodeTest: XCTestCase {

    func testDecodeSingleByteData() {
        let str = "abcdefghijklmn"
        let data: Data = str.data(using: .utf8)!
        var utf8decoder = UTF8Decoder(buffer: data)

        var i: Int = 0
        while let uint8arr = utf8decoder.read() {
           XCTAssertEqual(uint8arr, [data[data.index(data.startIndex, offsetBy: i)]]) 

           i += 1
        }

        XCTAssertEqual(i, str.characters.count)
    }

    func testDecodeMixBytesData() {
        let strArr = ["a","é", "あ", "👑"]
        let str = strArr.joined()
        let data: Data = str.data(using: .utf8)!
        
        var utf8decoder = UTF8Decoder(buffer: data)
        var i: Int = 0
        while let uint8arr = utf8decoder.read() {
            let data = Data(bytes: uint8arr)
            let char = String(data: data, encoding: .utf8)
            XCTAssertNotNil(char)
            XCTAssertEqual(char, strArr[i])

            i += 1
        }

        XCTAssertEqual(i, strArr.count)
    }

    func testDecodeSequenceData() {
        let strArr = ["a","é", "あ", "👑"]
        let str = strArr.joined()
        let data: Data = str.data(using: .utf8)!
        
        var utf8decoder = UTF8Decoder()
        var i: Int = 0
        for byte in data {
            utf8decoder.append(buffer: byte)
            while let uint8arr = utf8decoder.read() {
                let encode = Data(bytes: uint8arr)
                let decode = String(data: encode, encoding: .utf8)
                XCTAssertNotNil(decode)
                XCTAssertEqual(decode, strArr[i])

                i += 1
            }
        }

        XCTAssertEqual(i, strArr.count)
    }

}
