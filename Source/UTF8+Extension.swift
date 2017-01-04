//
//  Created by ysn551 on 01/04/17.
//  Copyright © 2016 ysn551. All rights reserved.
//

/**
 # UTF8 Extension
 */
extension UTF8 {
    static func width(_ unicodeScalar: UnicodeScalar) -> Int {
        var count = 0
        self.encode(unicodeScalar, into: { byte in 
            count += 1
        })
        return count
    }

    static func width(_ leadingByte: UInt8) -> Int? {
        guard UTF8.isContinuation(leadingByte) == false
            else { return nil }

        switch leadingByte & 0xF0 {
        case 0xC0: return 2
        case 0xE0: return 3
        case 0xF0: return 4
        default:   return 1
        }
    }
}

