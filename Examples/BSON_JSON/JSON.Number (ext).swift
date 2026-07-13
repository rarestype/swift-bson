public import BSON
public import JSON

extension JSON.Number: @retroactive BSONEncodable {
    public func encode(to bson: inout BSON.FieldEncoder) {
        let double: Double

        switch self {
        case .infinity(.plus):
            double = +.infinity

        case .infinity(.minus):
            double = -.infinity

        case .nan:
            double = .nan

        case .snan:
            double = .signalingNaN

        case .inline(let number):
            if  let int64: Int64 = number.as(Int64.self) {
                Int32.init(exactly: int64)?.encode(to: &bson) ?? int64.encode(to: &bson)
                return
            }

            let text: String = "\(self)"

            guard
            let value: Double = .init(text) else {
                text.encode(to: &bson)
                return
            }
            double = value

        case .fallback(let text):
            guard
            let value: Double = .init(text) else {
                text.encode(to: &bson)
                return
            }

            double = value
        }

        double.encode(to: &bson)
    }
}
