import UIKit


class ExpensesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExpensesCollectionViewCell"
    
    private var defaultExpensesImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default_expenses_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var expensesItemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pageIndex: Int = 0
    
    private var totalExpensesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(expensesItem: ExpensesItem) {
        expensesItemLabel.text = expensesItem.title
        totalExpensesLabel.text = "$\(String(format: "%.2f", expensesItem.totalExpenses))"
    }
    
    private func setupView() {
        
        // TODO: change background color
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(defaultExpensesImageView)
        contentView.addSubview(expensesItemLabel)
        contentView.addSubview(totalExpensesLabel)
        
        NSLayoutConstraint.activate(
            [
                // default expenses image view
                defaultExpensesImageView.topAnchor
                    .constraint(
                        equalTo: contentView.topAnchor,
                        constant: 20
                    ),
                defaultExpensesImageView.leadingAnchor
                    .constraint(
                        equalTo: contentView.leadingAnchor,
                        constant: 20
                    ),
                defaultExpensesImageView.widthAnchor.constraint(equalToConstant: 24),
                defaultExpensesImageView.heightAnchor.constraint(equalToConstant: 24),
                
                // title
                expensesItemLabel.topAnchor
                    .constraint(
                        equalTo: defaultExpensesImageView.bottomAnchor,
                        constant: 8
                    ),
                expensesItemLabel.leadingAnchor
                    .constraint(
                        equalTo: contentView.leadingAnchor,
                        constant: 20
                    ),
                
                // total expenses
                totalExpensesLabel.topAnchor
                    .constraint(
                        equalTo: expensesItemLabel.bottomAnchor,
                        constant: 32
                    ),
                totalExpensesLabel.leadingAnchor
                    .constraint(
                        equalTo: contentView.leadingAnchor,
                        constant: 20
                    )
            ]
        )
    }
}

