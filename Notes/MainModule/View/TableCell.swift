import UIKit

protocol TableCellOutput: AnyObject {
    func didTapButton(in cell: TableCell)
}

final class TableCell: UITableViewCell {
    
    private var isDone: Bool = false { didSet {
        button.backgroundColor = isDone ? .systemBlue.withAlphaComponent(0.5) : .clear } }
    weak var output: TableCellOutput?
    
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
    
    func configure(with note: ViewData.Note, output: TableCellOutput) {
        setupViews()
        titleLabel.attributedText = NSMutableAttributedString(string: note.title, attributes: [.strikethroughStyle: 0])
        descriptionLabel.text = note.body
        dateLabel.text = note.date
        isDone = note.isDone
        self.output = output
        updateTableCell()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        button.backgroundColor = .clear
        titleLabel.textColor = .black
        dateLabel.textColor = .black
        descriptionLabel.textColor = .black
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
        stack.distribution = .fillEqually
        
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
        updateTableCell()
        output?.didTapButton(in: self)
    }
    
    private func updateTableCell() {
        titleLabel.attributedText = NSMutableAttributedString(string: titleLabel.text ?? "", attributes: [.strikethroughStyle: isDone ? 1 : 0])
        titleLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
        descriptionLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
        dateLabel.textColor = .black.withAlphaComponent(isDone ? 0.5 : 1)
    }
}
