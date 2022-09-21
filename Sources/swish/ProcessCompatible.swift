import Foundation

protocol ProcessCompatible {
    func run() throws
    func suspend() -> Bool
    func resume() -> Bool
    func waitUntilExit()
}

extension Process: ProcessCompatible {}
