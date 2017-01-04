//
//  Created by ysn551 on 01/04/17.
//  Copyright © 2016 ysn551. All rights reserved.
//

import Foundation

/**
 # UTF8Decoder
 This struct has the feature to read one character as [UInt8] 
 from the serialized data.
 */
public struct UTF8Decoder {
    private var currentBuffer: Data = Data(capacity: 0)

    public init() {
    }

    public init(buffer: Data) {
        self.currentBuffer.append(contentsOf: buffer)
    }

    public mutating func append(buffer: Data) {
        self.currentBuffer.append(contentsOf: buffer)
    }

    public mutating func append(buffer: UInt8) {
        self.currentBuffer.append(buffer)
    }

    /// decodes raw data to a UTF8 Data as [UInt8] 
    public mutating func read() -> [UInt8]? {
        guard let leading = self.currentBuffer.first,
              let width = UTF8.width(leading),
              width <= self.currentBuffer.count
                else { return nil }

        let element = Array(self.currentBuffer[0..<width]) 
        self.currentBuffer.removeSubrange(0..<width)
        return element
    }
}
