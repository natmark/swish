import Foundation

struct Action {
    enum Command {
        case executable(executable: String)
        case builtin(command: BuiltinCommand)
    }

    var command: Command
    var arguments: [String]
}
