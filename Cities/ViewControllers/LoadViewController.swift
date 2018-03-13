import UIKit

class LoadViewController: UIViewController {
    
    @IBOutlet fileprivate weak var activityIndicatorView: UIActivityIndicatorView!
    
    var presenter: LoadPresenterProtocol = JSONLoadPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
    }
    
    func load() {
        
        DispatchQueue.main.async {
            
            self.view.isUserInteractionEnabled = false
            self.activityIndicatorView.isHidden = false
        }
        
        presenter.load { [unowned self] result, error in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    self.show(message: error.localizedDescription)
                } else if let result = result {
                    
                    App.shared.items = result
                    
                    self.performSegue(withIdentifier: StoryboardSegue.Main.segueList.rawValue, sender: nil)
                }
                
                self.activityIndicatorView.isHidden = true
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
