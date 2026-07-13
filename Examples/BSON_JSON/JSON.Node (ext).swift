public import BSON
public import JSON

extension JSON.Node: @retroactive BSONEncodable {
    public func encode(to bson: inout BSON.FieldEncoder) {
        switch self {
        case .null:
            BSON.Null.init().encode(to: &bson)

        case .bool(let bool):
            bool.encode(to: &bson)

        case .string(let self):
            self.value.encode(to: &bson)

        case .number(let self):
            self.encode(to: &bson)

        case .array(let self):
            self.encode(to: &bson)

        case .object(let self):
            self.encode(to: &bson)
        }
    }
}
