import Foundation

protocol {{module}}Routing: class {
}

class {{module}}Router: {{module}}Routing {
    private weak var delegate: {{module}}Delegate?

    init(delegate: {{module}}Delegate?) {
        self.delegate = delegate
    }
}
