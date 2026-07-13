public import BSON
public import JSON

extension JSON.Array: @retroactive BSONListEncodable {
    public func encode(to bson: inout BSON.ListEncoder) {
        for json: JSON.Node in self.elements {
            bson[+] = json
        }
    }
}
