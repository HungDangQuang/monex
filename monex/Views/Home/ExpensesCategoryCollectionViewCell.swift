import UIKit

class ExpensesCategoryCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "ExpensesCategoryCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var backgroundImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        contentView.addSubview(imageView)
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(titleLabel)
        
        contentView.layer.cornerRadius = 8
        // TODO: change background color later
        contentView.backgroundColor = .brown
        
        NSLayoutConstraint.activate([
            
            // background image view
            backgroundImageView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundImageView.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 30),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // image view
            imageView.centerXAnchor
                .constraint(equalTo: backgroundImageView.centerXAnchor),
            imageView.centerYAnchor
                .constraint(equalTo: backgroundImageView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            // title label
            titleLabel.leadingAnchor
                .constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor
                .constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configure(with expensesCategory: ExpensesCategory) {
        imageView.image = UIImage(named: expensesCategory.imageName)
        titleLabel.text = expensesCategory.categoryName
    }
}

