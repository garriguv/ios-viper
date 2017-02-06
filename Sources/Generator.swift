import Foundation
import Files
import Stencil
import PathKit

enum GeneratorError: Error {
    case emptyRendering(name: String, data: [String: Any])
}

class Generator {
    enum ModuleType {
        case BVIPER(module: String, type: String)
    }

    private let templates: String

    init(templates: String) throws {
        self.templates = templates
    }

    func generate(module: ModuleType, directory: Folder) throws {
        switch module {
        case .BVIPER(module: let moduleName, type: let type):
            let context = Context(dictionary: [
                "module": moduleName,
                "type": type
                ])
            let templates = try self.templates(module: module)
            try templates.forEach { (templateName, template) in
                let rendering = try template.render(context)
                guard let renderingData = rendering.data(using: .utf8) else {
                    throw GeneratorError.emptyRendering(name: templateName, data: context.flatten())
                }
                let file = try directory.createFile(named: "\(moduleName)\(templateName)", contents: renderingData)
                print("\(file.path)")
            }
        }
    }

    private func templates(module: ModuleType) throws -> [(String, Template)] {
        switch module {
        case .BVIPER:
            let loader = FileSystemLoader(paths: [Path(templates) + Path("BVIPER")])
            return try [
                "Builder.swift",
                "Interactor.swift",
                "Presenter.swift",
                "Router.swift",
                "View.swift",
                "ViewModel.swift"
                ].map {
                    ($0, try loader.loadTemplate(name: $0)!)
            }
        }
    }
}
