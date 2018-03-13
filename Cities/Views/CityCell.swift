import UIKit

class CityCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
}

extension CityCell: Resetable {
    
    func reset() {
        textLabel?.text = nil
    }
}

extension CityCell: Updatable {
    
    func update(model: Any?) {
        if let city = model as? City {
            textLabel?.text = "\(city.name), \(city.country)"
        }
    }
}
