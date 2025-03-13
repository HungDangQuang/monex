import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController: HomeViewController!
    var vc: ViewController!
    
    private lazy var customTabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 35 // Half of the button size
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        setupCustomTabBar()
    }
    
    private func setUpViewControllers() {
        homeViewController = HomeViewController()
        vc = ViewController()
        viewControllers = [homeViewController, vc]
    }
    
    private let tabBarIcons = ["Home", "Checklist", "Setting", "Notification 1"]
    
    private func setupCustomTabBar() {
        // Hide the default tab bar
        tabBar.isHidden = true
        
        // Add the custom tab bar view
        view.addSubview(customTabBarView)
        NSLayoutConstraint.activate(
            [
                customTabBarView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor
                    ),
                customTabBarView.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                customTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                customTabBarView.heightAnchor.constraint(equalToConstant: 60)
            ]
        )
        
        // Add center button
        view.addSubview(centerButton)
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: customTabBarView.topAnchor),
            centerButton.widthAnchor.constraint(equalToConstant: 70),
            centerButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        // Add tab bar buttons
        addTabBarButtons()
    }
    
    private func addTabBarButtons() {
        let remainingSpacing = (
            UIScreen.main.bounds.width - centerButton.frame
                .width) / 2 - 48
        
        
        for (index, iconName) in tabBarIcons.enumerated() {
            let button = UIButton()
            let image = UIImage(named: iconName)?.withRenderingMode(
                .alwaysTemplate
            )
            button.setImage(image, for: .normal)
            button.tintColor = index == 0 ? .systemBlue : .gray // Highlight the first button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            button.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
            
            customTabBarView.addSubview(button)
            // Position the buttons
            NSLayoutConstraint.activate([
                button.centerYAnchor
                    .constraint(equalTo: customTabBarView.centerYAnchor),
                button.widthAnchor.constraint(equalToConstant: 24),
                button.heightAnchor.constraint(equalToConstant: 24)
            ])
            if index <= tabBarIcons.count / 2 - 1 {
                NSLayoutConstraint.activate(
                    [
                        button.centerXAnchor
                            .constraint(
                                equalTo: view.centerXAnchor,
                                constant: -remainingSpacing
                                / CGFloat((index + 1))),
                    ]
                )
            } else {
                NSLayoutConstraint.activate(
                    [
                        button.centerXAnchor
                            .constraint(
                                equalTo: view.centerXAnchor,
                                constant: remainingSpacing
                                / CGFloat((index - 1)))
                    ]
                )
            }
            
        }
    }
    
    @objc private func tabBarButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateTabBarButtonColors(selectedIndex: sender.tag)
    }
    
    private func updateTabBarButtonColors(selectedIndex: Int) {
        for (index, button) in customTabBarView.subviews.enumerated() where button is UIButton {
            (button as? UIButton)?.tintColor = index == selectedIndex ? .systemBlue : .gray
        }
    }
    
    
    @objc func centerButtonTapped() {
        print("Center button tapped!")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //        if viewController.isKind(of: ViewController.self) {
        //            vc.modalTransitionStyle = .crossDissolve
        //            self.present(vc, animated: true)
        //        }
        return true
    }
}
