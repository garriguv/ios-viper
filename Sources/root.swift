import Guaka
import Files
import FileUtils

#if RELEASE
let templatesPath = "/usr/src/ios-viper/Templates"
#else
let templatesPath = "Templates"
#endif

let rootFlags = [
    Flag(shortName: "m", longName: "module", type: String.self, description: "The name of the module", required: true),
    Flag(shortName: "t", longName: "type", type: String.self, description: "The type of the module", required: true),
    Flag(shortName: "d", longName: "directory", type: String.self, description: "The directory in which to create the module", required: true)
]
let rootCommand = Command(usage: "ios-viper",
                          shortMessage: "(B)VIPER module template generator",
                          flags: rootFlags,
                          example: "  ios-viper -m MyModule -t UIView -d /path/to/module",
                          run: execute)

private func execute(flags: Flags, args: [String]) {
    let module = flags.getString(name: "module")!
    let type = flags.getString(name: "type")!
    let directory = flags.getString(name: "directory")!

    if !Path.exists(directory) {
        print("Creating directory: \(directory)")
        Directory.create(atPath: directory)
    }

    do {
        let generator = try Generator(templates: templatesPath)
        try generator.generate(module: .BVIPER(module: module, type: type), directory: try Folder(path: directory))
    } catch {
        rootCommand.fail(statusCode: 1, errorMessage: "\(error)")
    }
}
