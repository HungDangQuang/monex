import UIKit


class HomeExpensesItemCollect: ViewController {
    
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
    
    init(item: ExpensesItem, index: Int) {
        super.init(nibName: nil, bundle: nil)
        expensesItemLabel.text = item.title
        pageIndex = index
        totalExpensesLabel.text = "$\(item.totalExpenses)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        print("setUpView")
        
        view.addSubview(defaultExpensesImageView)
        view.addSubview(expensesItemLabel)
        view.addSubview(totalExpensesLabel)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate(
            [
                // default expenses image view
                defaultExpensesImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                defaultExpensesImageView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
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
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
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
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20
                    )
            ]
        )
    }
}

