import Foundation
import Files
import Mustache

enum GeneratorError: Error {
  case emptyRendering(name: String, data: [String: Any])
}

class Generator {
  enum ModuleType {
    case BVIPER(name: String, viewType: String)
  }

  private let module: ModuleType
  private let directory: Folder
  private let templates: TemplateRepository

  init(module: ModuleType, directory: Folder, templates: Folder) throws {
    self.module = module
    self.directory = directory
    self.templates = TemplateRepository(directoryPath: templates.path)
  }

  func generate() throws {
    switch module {
    case .BVIPER(name: let name, viewType: let view):
      let data = [
        "module": name,
        "type": view
      ]
      try generate(module: name, templateName: "Builder.swift", withData: data)
      try generate(module: name, templateName: "Interactor.swift", withData: data)
      try generate(module: name, templateName: "Presenter.swift", withData: data)
      try generate(module: name, templateName: "Router.swift", withData: data)
      try generate(module: name, templateName: "View.swift", withData: data)
      try generate(module: name, templateName: "ViewModel.swift", withData: data)
    }
  }

  private func generate(module: String, templateName name: String, withData data: [String: Any]) throws {
    let template = try templates.template(named: name)
    let rendering = try template.render(with: Box(data))
    guard let renderingData = rendering.data(using: .utf8) else {
      throw GeneratorError.emptyRendering(name: name, data: data)
    }
    try directory.createFile(named: "\(module)\(name)", contents: renderingData)
  }
}
