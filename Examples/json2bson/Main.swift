import ArgumentParser
import BSON
import BSON_JSON
import JSON
import System_ArgumentParser
import SystemIO

struct Main {
    @Argument(
        help: "input json path",
    ) var json: FilePath

    @Option(
        name: [.customLong("bson"), .customShort("o")],
        help: "input bson path",
    ) var bson: FilePath
}
@main extension Main: ParsableCommand {
    func run() throws {
        let json: JSON = .init(utf8: try self.json.read()[...])
        let node: JSON.Node = try .init(parsing: json)

        switch node {
        case .object(let json):
            let bson: BSON.Document = .init(encoding: json)
            try self.bson.overwrite(with: bson.bytes)

        case .array(let json):
            let bson: BSON.List = .init(with: json.elements.encode(to:))
            try self.bson.overwrite(with: bson.bytes)

        default:
            throw ExitCode.failure
        }
    }
}
