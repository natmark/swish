import Foundation

struct LineParser {
    static func parse(line: String, environment: [String: String]) -> Action? {
        let commandList = line
            .split(separator: "|")
            .map { pipeSplitedText in
                pipeSplitedText
                    .split(separator: " ")
                    .map { String($0) }
                    .map { replaceEnvironment(from: String($0), environment: environment) }
            }
            .map { command -> Action.CommandKind? in
                if let executable = command.first {
                    let arguments = Array(command.dropFirst())
                    if let builtinCommand = BuiltinCommand(rawValue: executable) {
                        return .builtin(command: builtinCommand, arguments: arguments)
                    } else {
                        return .executable(executable: executable, arguments: arguments)
                    }
                } else {
                    return nil // FIXME: parse error の考慮が必要
                }
            }
            .compactMap { $0 }
        
        if commandList.isEmpty {
            return nil
        } else if commandList.count == 1 {
            return Action.single(command: commandList[0])
        } else {
            let reversedCommandList: [Action.CommandKind] = commandList.reversed()
            
            let last = reversedCommandList[0]
            let secondLast = reversedCommandList[1]

            return reversedCommandList
                .dropFirst(2)
                .reduce(Action.pipe(command: secondLast, action: .single(command: last))) {
                    Action.pipe(command: $1, action: $0)
                }
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
