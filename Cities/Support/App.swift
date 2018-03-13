import UIKit

class App {
    
    static let shared: App = App()
    var items: [City] = []
    
    private init() { }
    
    func didFinishLauching() {
        
        theme()
    }
}

extension App {
    
    func theme() {
        
        let navAppearance = UINavigationBar.appearance()
        navAppearance.isTranslucent = true
        navAppearance.tintColor = Palette.secondary.color()
        navAppearance.barTintColor = Palette.primary.color()
        navAppearance.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: Palette.secondary.color()]
        
        if #available(iOS 11, *) {
            
            navAppearance.prefersLargeTitles = true
            navAppearance.largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: Palette.secondary.color(),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26)
            ]
        }
        
        UISegmentedControl.appearance().tintColor = Palette.secondary.color()
        UIActivityIndicatorView.appearance().color = Palette.primary.color()
        
        UISearchBar.appearance().tintColor = Palette.secondary.color()
        UITableView.appearance().sectionIndexColor = Palette.primary.color()
        
        let searchTextfieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        
        searchTextfieldAppearance.defaultTextAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: Palette.secondary.color()
        ]
    }
}
