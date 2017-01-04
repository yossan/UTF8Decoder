import Foundation

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
