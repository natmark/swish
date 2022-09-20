import Foundation

struct ActionExecuter {
    static func execute(action: Action) {
        switch action.command {
        case .builtin(let command):
            executeBuiltin(command: command, arguments: action.arguments)
        case .executable(let executable):
            executeCommand(executable: executable, arguments: action.arguments)
        }
    }

    private static func executeBuiltin(command: BuiltinCommand, arguments: [String]) {
        switch command {
        case .cd:
            BuiltinCommand.cd(arguments: arguments)
        case .exit:
            BuiltinCommand.exit(arguments: arguments)
        case .help:
            BuiltinCommand.help(arguments: arguments)
        }
    }
    
    private static func executeCommand(executable: String, arguments: [String]) {
        let process = Process()
        process.environment = ProcessInfo.processInfo.environment

        if executable.hasPrefix("/") || executable.hasPrefix(".") {
            process.executableURL = URL(fileURLWithPath: executable)
            process.arguments = arguments
        } else {
            process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            process.arguments = [executable] + arguments
        }

        do {
            try process.run()
        } catch {
            print("swish:", error)
        }
        process.waitUntilExit()
    }
}
