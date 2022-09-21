import Foundation

indirect enum Action {
    indirect enum CommandKind {
        case executable(executable: String, arguments: [String])
        case builtin(command: BuiltinCommand, arguments: [String])
    }
    case pipe(command: CommandKind, action: Action)
    case single(command: CommandKind)
}
