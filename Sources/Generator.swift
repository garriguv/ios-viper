import Foundation
import Files
import Mustache

enum GeneratorError: Error {
  case emptyRendering(name: String, data: [String: Any])
}

class Generator {
  enum ModuleType {
    case BVIPER(module: String, type: String)
  }

  private let templates: Folder

  init(templates: Folder) throws {
    self.templates = templates
  }

  func generate(module: ModuleType, directory: Folder) throws {
    switch module {
    case .BVIPER(module: let moduleName, type: let type):
      let data = [
        "module": moduleName,
        "type": type
      ]
      let templates = try self.templates(module: module)
      try templates.forEach { (templateName, template) in
        let rendering = try template.render(with: Box(data))
        guard let renderingData = rendering.data(using: .utf8) else {
          throw GeneratorError.emptyRendering(name: templateName, data: data)
        }
        let file = try directory.createFile(named: "\(moduleName)\(templateName)", contents: renderingData)
        print("\(file.path)")
      }
    }
  }

  private func templates(module: ModuleType) throws -> [(String, Template)] {
    switch module {
    case .BVIPER:
      let repository = TemplateRepository(directoryPath: try templates.subfolder(named: "BVIPER").path)
      return try [
        "Builder.swift",
        "Interactor.swift",
        "Presenter.swift",
        "Router.swift",
        "View.swift",
        "ViewModel.swift"
        ].map {
          ($0, try repository.template(named: $0))
      }
    }
  }
}
