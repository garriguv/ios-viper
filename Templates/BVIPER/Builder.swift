import Foundation
import UIKit

public protocol {{module}}Delegate: class {
}

public protocol {{module}}Building: class {
    func makeModule(delegate: {{module}}Delegate?) -> {{type}}
}

public class {{module}}Builder: {{module}}Building {
    public func makeModule(delegate: {{module}}Delegate?) -> {{type}} {
        let router = {{module}}Router(delegate: delegate)
        let interactor = {{module}}Interactor()
        let presenter = {{module}}Presenter(router: router, interactor: interactor)
        let view = {{module}}View()

        view.presenter = presenter
        presenter.view = view

        interactor.delegate = presenter

        return view
    }
}
