import UIKit

class TutorialChildViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var pageIndex: Int = 0
    
    init(page: TutorialContent, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.pageIndex = index
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        imageView.image = UIImage(named: page.imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate(
            [
                // image view
                imageView.topAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: 0
                    ),
                
                imageView.leadingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
                        multiplier: 0
                    ),
                
                imageView.trailingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor,
                        multiplier: 0
                    ),
                
                imageView.heightAnchor.constraint(equalToConstant: 200),
                
                // Title label
                titleLabel.topAnchor
                    .constraint(equalTo: imageView.bottomAnchor, constant: 20),
                titleLabel.leadingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
                        multiplier: 0
                    ),
                titleLabel.trailingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor,
                        multiplier: 0
                    ),
                
                // Description label
                descriptionLabel.topAnchor
                    .constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                descriptionLabel.leadingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
                        multiplier: 0
                    ),
                descriptionLabel.trailingAnchor
                    .constraint(
                        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor,
                        multiplier: 0
                    ),
                
            ]
        )
    }
}

