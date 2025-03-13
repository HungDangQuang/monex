import UIKit

class EntryTableViewCell: UITableViewCell {
    
    static let identifier = "EntryTableViewCell"
    
    private lazy var backgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "EBEEF0")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var labelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expenditureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var spendingTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = identifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(labelImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(expenditureLabel)
        contentView.addSubview(spendingTypeLabel)
        contentView.setContentHuggingPriority(.required, for: .vertical)
        contentView
            .setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            // Background Image View
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 40),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 40),

            // Label Image View
            labelImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            labelImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            labelImageView.widthAnchor.constraint(equalToConstant: 30),
            labelImageView.heightAnchor.constraint(equalToConstant: 30),

            // Title Label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Add padding
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: expenditureLabel.leadingAnchor, constant: -8),

            // Date Label
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: spendingTypeLabel.leadingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), // Define bottom constraint

            // Expenditure Label
            expenditureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            expenditureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Spending Type Label
            spendingTypeLabel.topAnchor.constraint(equalTo: expenditureLabel.bottomAnchor, constant: 4),
            spendingTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            spendingTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Define bottom constraint
        ])
    }
    
    public func configure(spendingItem: SpendingItem) {
        labelImageView.image = UIImage(named: spendingItem.imageName)
        titleLabel.text = spendingItem.title
        dateLabel.text = spendingItem.spendingDate
        expenditureLabel.text = spendingItem.expenditure
        spendingTypeLabel.text = spendingItem.spendingType
    }
}
