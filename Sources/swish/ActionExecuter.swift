import Foundation

struct ActionExecuter {
    static func execute(action: Action) {
        switch action {
        case .pipe(let command, let action):
            // TODO: actionがpipeの場合のケース
            if case .single(let pipeCommand) = action {
                let pipe = Pipe()
                let first = ProcessGenerator.generate(
                    command: command,
                    standardOutput: pipe
                )
                
                do {
                    try first.run()
                } catch {
                    print("swish:", error)
                }

                let second = ProcessGenerator.generate(
                    command: pipeCommand,
                    standardInput: pipe
                )

                do {
                    try second.run()
                } catch {
                    print("swish:", error)
                }
                second.waitUntilExit()
            }            
        case .single(let command):
            let process = ProcessGenerator.generate(command: command)
            do {
                try process.run()
            } catch {
                print("swish:", error)
            }
            process.waitUntilExit()
        }
    }
}
