import UIKit
import Foundation

class HomeViewController: ViewController {
    
    private var homeScreenTitle: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        let defaultAvatar = UIImage(named: "DefaultUser")
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.image = defaultAvatar
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var topAppBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // mock data to display UI
    private let expensesItems: [ExpensesItem] = [
        ExpensesItem(title: "Total Salary", totalExpenses: 1289.38),
        ExpensesItem(title: "Total Expenses", totalExpenses: 298.16),
        ExpensesItem(title: "Monthly", totalExpenses: 3.38)
    ]
    
    private lazy var expensesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView
            .register(
                ExpensesCollectionViewCell.self,
                forCellWithReuseIdentifier: ExpensesCollectionViewCell.identifier
            )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let expensesCategories: [ExpensesCategory] = [
        ExpensesCategory(categoryName: "Savings", imageName: "Add"),
        ExpensesCategory(categoryName: "Remind", imageName: "Notification"),
        ExpensesCategory(categoryName: "Budget", imageName: "default_expenses_logo")
    ]
    
    private lazy var expeneseCategoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        
        collectionView
            .register(
                ExpensesCategoryCollectionViewCell.self,
                forCellWithReuseIdentifier: ExpensesCategoryCollectionViewCell.identifier
            )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var latestEntriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Latest Entries"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var spendingTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView
            .register(
                EntryTableViewCell.self,
                forCellReuseIdentifier: EntryTableViewCell
                    .identifier)
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.estimatedRowHeight = 60
        return tableView
    }()
    
    private let spendingData: [SpendingItem] = [
        SpendingItem(
            imageName: "Group",
            title: "Food",
            spendingDate: "20 Feb 2024",
            expenditure: "+20$ + VAT 0.5%",
            spendingType: "Google Play"
        ),
        SpendingItem(
            imageName: "bike",
            title: "Uber",
            spendingDate: "13 Mar 2024",
            expenditure: "-18$ + VAT 0.8%",
            spendingType: "Cash"
        ),
        SpendingItem(
            imageName: "Shopping",
            title: "Shopping",
            spendingDate: "11 Mar 2024",
            expenditure: "-400$ + VAT 0.12%",
            spendingType: "Paytm"
        ),
    ]
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        setUpView()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    private func setUpView() {
        print("setUpView")
        view.addSubview(topAppBar)
        topAppBar.addSubview(avatarImageView)
        topAppBar.addSubview(homeScreenTitle)
        view.addSubview(expensesCollectionView)
        view.addSubview(expeneseCategoryCollectionView)
        view.addSubview(latestEntriesLabel)
        view.addSubview(spendingTableView)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate(
            [
                
                // top app bar
                topAppBar.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                topAppBar.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                topAppBar.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                topAppBar.heightAnchor.constraint(equalToConstant: 100),
                
                // avatar image view
                avatarImageView.trailingAnchor
                    .constraint(
                        equalTo: topAppBar.trailingAnchor,
                        constant: -20
                    ),
                avatarImageView.widthAnchor.constraint(equalToConstant: 50),
                avatarImageView.heightAnchor.constraint(equalToConstant: 50),
                avatarImageView.centerYAnchor
                    .constraint(equalTo: topAppBar.centerYAnchor),
                
                // home screen title
                homeScreenTitle.leadingAnchor
                    .constraint(equalTo: topAppBar.leadingAnchor, constant: 20),
                homeScreenTitle.centerYAnchor
                    .constraint(equalTo: topAppBar.centerYAnchor),
                
                // expenses collection view
                expensesCollectionView.topAnchor
                    .constraint(equalTo: topAppBar.bottomAnchor),
                expensesCollectionView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20
                    ),
                expensesCollectionView.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                expensesCollectionView.heightAnchor.constraint(equalToConstant: 150),
                
                // expenses category collection view
                expeneseCategoryCollectionView.topAnchor
                    .constraint(equalTo: expensesCollectionView.bottomAnchor),
                expeneseCategoryCollectionView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20
                    ),
                expeneseCategoryCollectionView.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                expeneseCategoryCollectionView.heightAnchor.constraint(equalToConstant: 90),
                
                
                // latest entries label
                latestEntriesLabel.topAnchor
                    .constraint(
                        equalTo: expeneseCategoryCollectionView.bottomAnchor,
                        constant: 50
                    ),
                latestEntriesLabel.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
                // spending table view
                spendingTableView.topAnchor
                    .constraint(
                        equalTo: latestEntriesLabel.bottomAnchor,
                        constant: 20
                    ),
                spendingTableView.leadingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                spendingTableView.trailingAnchor
                    .constraint(
                        equalTo: view.safeAreaLayoutGuide.trailingAnchor
                    ),
                spendingTableView.heightAnchor.constraint(equalToConstant: 200)
            ]
        )
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(
            "Item \(indexPath.item) \(indexPath.row) \(indexPath.section) is selected"
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.expensesCollectionView {
            return expensesItems.count
        }
        return expensesCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.expensesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpensesCollectionViewCell.identifier, for: indexPath) as? ExpensesCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(expensesItem: expensesItems[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpensesCategoryCollectionViewCell.identifier, for: indexPath) as? ExpensesCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: expensesCategories[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.expensesCollectionView) {
            let width = (view.frame.width - 50) / 2
            return CGSize(width: width, height: 140)
        }
        let width = (view.frame.width - 70) / 3
        return CGSize(width: width, height: 50)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EntryTableViewCell.identifier,
            for: indexPath
        ) as? EntryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(spendingItem: spendingData[indexPath.item])
        return cell
    }
}
