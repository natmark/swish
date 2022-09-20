import Foundation
import Darwin

struct Action {
    var executable: String
    var arguments: [String]
}

func main() {
    swishLoop()
}

func swishLoop() {
    while let line = readLine() {
        let action = parseLine(line: line)
        guard let action = action else { continue }
        executeAction(action: action)
    }
}

func executeAction(action: Action) {
    let process = Process()
    if action.executable.hasPrefix("/") || action.executable.hasPrefix(".") {
        process.executableURL = URL(fileURLWithPath: action.executable)
        process.arguments = action.arguments
    } else {
        process.executableURL =  URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = [action.executable] + action.arguments
    }

    do {
        try process.run()
    } catch {
        print("swish:", error)
    }
    process.waitUntilExit()
}

func parseLine(line: String) -> Action? {
    let command = line.split(separator: " ").map { String($0) }
    if let executable = command.first {
        return Action(executable: executable, arguments: Array(command.dropFirst()))
    } else {
        return nil
    }
}

main()
