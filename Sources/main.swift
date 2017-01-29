import Commander

let main = command(
    Argument<String>("name", description: "Name of the module"),
    Argument<String>("directory", description: "Directory in which to create the module")
    ) { name, directory in
    print("Generating module named \(name) at path \(directory)")
}

main.run()
