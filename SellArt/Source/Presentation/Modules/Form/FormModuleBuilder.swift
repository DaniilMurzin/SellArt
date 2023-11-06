import UIKit

class FormModuleBuilder {
    
    static func build() -> UIViewController {
        
        let presenter = FormPresenter()
        let formViewController = FormViewController(presenter: presenter)
        
        presenter.attachedView(formViewController)
        
        return formViewController
    }
}
