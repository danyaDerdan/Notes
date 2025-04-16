import UIKit

final class TableCell: UITableViewCell {
    
    private var isDone: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        let attributedText = NSMutableAttributedString(string: label.text ?? "", attributes: [.strikethroughStyle: 1])
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 14
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        return button
    }()
    
    func configure(with text: String) {
        setupViews()
        titleLabel.attributedText = NSMutableAttributedString(string: text, attributes: [.strikethroughStyle: 0])
        descriptionLabel.text = "Я крутой челик устроюсь на стажу в т банк потом бам бам машина бэха элитная потом хата"
        dateLabel.text = "9/03/2024"
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
}


private extension TableCell {
    func setupViews() {
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        addSubview(stack)
        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            button.widthAnchor.constraint(equalToConstant: 28),
            button.heightAnchor.constraint(equalToConstant: 28),
            
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }
    
    @objc func buttonTapped() {
        isDone.toggle()
        button.backgroundColor = isDone ? .systemBlue.withAlphaComponent(0.5) : .clear
        titleLabel.attributedText = NSMutableAttributedString(string: titleLabel.text ?? "", attributes: [.strikethroughStyle: isDone ? 1 : 0])
        titleLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
        descriptionLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
        dateLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
    }
}

