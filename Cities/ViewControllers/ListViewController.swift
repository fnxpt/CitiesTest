import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var searchController: UISearchController?
    
    var presenter: GroupableListPresenterProtocol = ListPresenter(items: App.shared.items)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        reset()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? MapViewController,
            let item = sender as? City {
            
            vc.city = item
        }
    }
    
    func configView() {
        
        title = "Cities"
        
        tableView.tableFooterView = UIView()
        tableView.register(identifier: presenter.cellType.className)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.delegate = self
        searchController?.dimsBackgroundDuringPresentation = true
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchResultsUpdater = self
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            
            self.navigationItem.searchController = searchController
        } else if let searchController = searchController {
            
            searchController.searchBar.autoresizingMask = .flexibleWidth
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchBar.sizeToFit()
        }
    }
    
    func reset() {
        load()
    }
    
    func load(text: String? = nil) {
        
        DispatchQueue.main.async {

            self.activityIndicatorView.isHidden = false
        }
        presenter.load(text: text) { [unowned self] error in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    self.show(message: error.localizedDescription)
                } else {
                    
                    self.tableView.reloadData()
                }
                
                self.activityIndicatorView.isHidden = true
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.numberOfGroups()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfItems(group: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellType.className)
        
        if let item = presenter.item(at: indexPath),
            let updatable = cell as? Updatable {
            
            updatable.update(model: item)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        return presenter.title(for: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter.indexes()
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.item(at: indexPath) else { return }

        performSegue(withIdentifier: StoryboardSegue.Main.segueDetail.rawValue, sender: item)
    }
}

extension ListViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {

        reset()
    }
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if searchController.isActive {
            
            load(text: text)
        }
    }
}
