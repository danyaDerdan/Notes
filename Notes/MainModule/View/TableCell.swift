import UIKit

final class TableCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    func configure(with text: String) {
        setupViews()
        titleLabel.text = text
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
}


private extension TableCell {
    func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

