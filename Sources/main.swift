import Commander
import Files
import Foundation

let main = command(
  Argument<String>("name", description: "Name of the module"),
  Argument<String>("view", description: "Type of the view (UIViewController, UIView, UICollectionViewCell...)"),
  Argument<String>("directory", description: "Directory in which to create the module"),
  Option("template", "Template/BVIPER", description: "Directory in which the template is stored")
  ) { name, view, directory, templates in
    do {
      let generator = try Generator(module: .BVIPER(name: name, viewType: view), directory: try Folder(path: directory), templates: try Folder(path: templates))
      try generator.generate()
    } catch {
      print("\(error)")
      exit(1)
    }
}

main.run()
