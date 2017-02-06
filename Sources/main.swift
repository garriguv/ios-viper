import Guaka

let version = "v0.4.0"

setupCommands()

let versionFlag = Flag(shortName: "v", longName: "version", value: false, description: "Prints the version", inheritable: true)

rootCommand.add(flag: versionFlag)
rootCommand.inheritablePreRun = { flags, args in
    if let version = flags.getBool(name: "version"), version == true {
        print(version)
        return false
    }
    return true
}

rootCommand.execute()
