import Foundation

struct LineParser {
    static func parse(line: String, environment: [String: String]) -> Action? {
        let command = line
            .split(separator: " ")
            .map { replaceEnvironment(from: String($0), environment: environment) }
        
        if let executable = command.first {
            let arguments = Array(command.dropFirst())
            if let builtinCommand = BuiltinCommand(rawValue: executable) {
                return .init(command: .builtin(command: builtinCommand), arguments: arguments)
            } else {
                return .init(command: .executable(executable: executable), arguments: arguments)
            }
        } else {
            return nil
        }
    }
    
    private static func replaceEnvironment(from text: String, environment: [String: String]) -> String {
        text.split(separator: "/").map { element -> String in
            if element.hasPrefix("$") {
                return environment[String(element.dropFirst())] ?? String(element)
            } else {
                return String(element)
            }
        }.joined(separator: "/")
    }
}
