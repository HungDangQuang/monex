import UIKit

class IntroductionViewController: UIViewController {
    
    lazy var horizontalLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "HorizontalLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    lazy var letGoButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("LET'S GO", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        return button
    }()
    
    private let pageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tutorialPages : [TutorialContent] = [
        TutorialContent(title: "Note Down Expenses", description: "Daily note your expenses to help manage money", imageName: "Tutorial1"),
        TutorialContent(title: "Simple Money Management", description: "Get your notifications or alert when you do the over expenses", imageName: "Tutorial2"),
        TutorialContent(title: "Easy to Track and Analize", description: "Tracking your expense help make sure you don't overspend", imageName: "Tutorial3"),
    ]
    
    private lazy var pageControllers : [UIViewController] = {
        tutorialPages.enumerated().map { index, page in
            TutorialChildViewController(page: page, index: index)
        }
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .accent
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .pageIndicatorTint
        return control
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        pageVC.delegate = self
        pageVC.dataSource = self
        return pageVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        setUpView()
        setUpPageViewController()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        
        view.addSubview(letGoButton)
        view.addSubview(horizontalLogo)
        view.addSubview(pageContainerView)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate(
            [
                // Logo Constraints
                horizontalLogo.topAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: 52),
                horizontalLogo.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 125
                    ),
                horizontalLogo.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                        constant: -125
                    ),
                
                // Button Constraints
                letGoButton.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 24
                    ),
                letGoButton.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                        constant: -24
                    ),
                letGoButton.bottomAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                        constant: -53
                    ),
                letGoButton.heightAnchor.constraint(equalToConstant: 48),
            ]
        )
        
        pageControl.numberOfPages = tutorialPages.count
        pageControl.currentPage = 0
    }
    
    private func setUpPageViewController() {
        addChild(pageViewController)
        pageContainerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Configure page view controller's view
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                pageContainerView.topAnchor
                    .constraint(
                        equalTo: horizontalLogo.bottomAnchor,
                        constant: 20
                    ),
                
                pageContainerView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor
                    ),
                
                pageContainerView.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor
                    ),
                
                pageContainerView.heightAnchor.constraint(equalToConstant: 330),
                
                pageControl.bottomAnchor
                    .constraint(
                        equalTo: pageContainerView.bottomAnchor,
                        constant: 20
                    ),
                
                pageControl.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor),
                
                // Pager Constraints
                pageViewController.view.topAnchor
                    .constraint(
                        equalTo: pageContainerView.topAnchor
                    ),
                pageViewController.view.leadingAnchor
                    .constraint(
                        equalTo: pageContainerView.leadingAnchor
                    ),
                pageViewController.view.trailingAnchor
                    .constraint(
                        equalTo: pageContainerView.trailingAnchor),
                pageViewController.view.bottomAnchor
                    .constraint(equalTo: pageContainerView.bottomAnchor)
                
            ]
        )
        
        if let firstPage = pageControllers.first {
            pageViewController
                .setViewControllers(
                    [firstPage],
                    direction: .forward,
                    animated: true
                )
        }
    }
    
    
    @objc func skipAction() {
        print("Go to the next screen")
    }
    
}

extension IntroductionViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? TutorialChildViewController else { return nil }
        let previousIndex = currentViewController.pageIndex - 1
        guard previousIndex >= 0 else { return nil }
        return pageControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? TutorialChildViewController else { return nil }
        let nextIndex = currentViewController.pageIndex + 1
        guard nextIndex < pageControllers.count else { return nil }
        return pageControllers[nextIndex]
    }
}

extension IntroductionViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            if let currentController = pageViewController.viewControllers?.first as? TutorialChildViewController {
                pageControl.currentPage = currentController.pageIndex
            }
        }
    }
    
}
