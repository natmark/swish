import Foundation

extension BuiltinCommand {
    static func cd(arguments: [String]) {
        let fileManager = FileManager.default
        if let path = arguments.first {
            fileManager.changeCurrentDirectoryPath(path)
        } else {
            fileManager.changeCurrentDirectoryPath(
                fileManager.homeDirectoryForCurrentUser.path
            )
        }
    }
}


