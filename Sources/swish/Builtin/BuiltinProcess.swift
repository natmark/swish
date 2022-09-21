import Foundation

struct BuiltinProcess: ProcessCompatible {
    var command: BuiltinCommand
    var arguments: [String]

    func run() throws {
        switch command {
        case .cd:
            BuiltinCommand.cd(arguments: arguments)
        case .exit:
            BuiltinCommand.exit(arguments: arguments)
        case .help:
            BuiltinCommand.help(arguments: arguments)
        }
    }
    
    func suspend() -> Bool {
        return true // TODO: Not implemented
    }
    
    func resume() -> Bool {
        return true // TODO: Not implemented
    }
    
    func waitUntilExit() {
        // TODO: Not implemented
    }

}
