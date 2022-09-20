import Foundation
import Darwin

func main() {
    let environment = ProcessInfo.processInfo.environment

    while let line = readLine() {
        let action = LineParser.parse(line: line, environment: environment)
        guard let action = action else { continue }
        ActionExecuter.execute(action: action)
    }
}

main()
