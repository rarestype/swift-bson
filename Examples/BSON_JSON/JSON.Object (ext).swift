public import BSON
public import JSON

extension JSON.Object: @retroactive BSONDocumentEncodable {
    public func encode(to bson: inout BSON.DocumentEncoder<Key>) {
        for json: (key: JSON.Key, value: JSON.Node) in self.fields {
            bson[json.key] = json.value
        }
    }
}
