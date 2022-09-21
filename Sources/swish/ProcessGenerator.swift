import Foundation

struct ProcessGenerator {
    static func generate(
        command: Action.CommandKind,
        environment: [String: String] = ProcessInfo.processInfo.environment,
        standardInput: Any? = Process().standardInput,
        standardOutput: Any? = Process().standardOutput
    ) -> ProcessCompatible {
        switch command {
        case .builtin(let command, let arguments):
            return BuiltinProcess(command: command, arguments: arguments)
        case .executable(let executable, let arguments):
            let process = Process()
    
            process.environment = environment
            process.standardInput = standardInput
            process.standardOutput = standardOutput

            if executable.hasPrefix("/") || executable.hasPrefix(".") {
                process.executableURL = URL(fileURLWithPath: executable)
                process.arguments = arguments
            } else {
                process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
                process.arguments = [executable] + arguments
            }
            
            return process
        }
    }
}
