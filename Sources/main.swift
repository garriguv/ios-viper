import Commander
import Files
import Foundation

let main = command(
  Argument<String>("name", description: "Name of the module"),
  Argument<String>("view", description: "Type of the view (UIViewController, UIView, UICollectionViewCell...)"),
  Argument<String>("directory", description: "Directory in which to create the module")
  ) { name, view, directory in
    do {
      let generator = try Generator(templates: try Folder(path: "/usr/src/ios-viper/Templates"))
      try generator.generate(module: .BVIPER(name: name, viewType: view), directory: try Folder(path: directory))
    } catch {
      print("\(error)")
      exit(1)
    }
}

main.run()
