//
//  FollowingFollowerViewController.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import UIKit

class FollowingFollowerViewController: UIViewController {
    
    lazy var usernameTitle: UILabel = {
        let usernameTitle = UILabel()
        usernameTitle.textAlignment = .center
        usernameTitle.text = "Username"
        
        return usernameTitle
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width / 1.1,
                                 height: view.frame.size.height / 20)
        
        return UICollectionView(frame: .zero,
                                collectionViewLayout: layout)
    }()
    
    lazy var segmentedButtonsView: SegmentedButtonsView = {
        
        let segmentedButtonsView = SegmentedButtonsView()
        
        segmentedButtonsView.setLabelsTitles(titles: ["Following", "Followers"])
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        segmentedButtonsView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        segmentedButtonsView.layer.borderColor = UIColor(ciColor: .white).cgColor
        segmentedButtonsView.layer.borderWidth = 0.5
        
        return segmentedButtonsView
        
    }()
    
    private var segmentedButtonIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupConstraints()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        usernameTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTitle)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedButtonsView)
        segmentedButtonsView.segmentedControlDelegate = self
        
        collectionView.register(UserResultCollectionViewCell.self,
                                forCellWithReuseIdentifier: UserResultCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            usernameTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            usernameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usernameTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameTitle.widthAnchor.constraint(equalToConstant: view.frame.width),
            usernameTitle.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: usernameTitle.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            segmentedButtonsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            segmentedButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedButtonsView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedButtonsView.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
}

extension FollowingFollowerViewController: UICollectionViewDelegate, UICollectionViewDataSource, CellActionDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedButtonIndex == 0 ? UserResult.followingsResults.count : UserResult.followersResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserResultCollectionViewCell.identifier,
                                                      for: indexPath) as! UserResultCollectionViewCell
        
        cell.configure(with: segmentedButtonIndex == 0 ? UserResult.followingsResults[indexPath.row] : UserResult.followersResults[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func buttonTapped(in cell: UserResultCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        print("Button tapped in cell at index: \(indexPath.item)")
        
        let alertController = UIAlertController(title: "Action button info",
                                                message: "You've tapped action button.",
                                                preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertAction.Style.destructive) { _ in
                
                print("Cancel button tapped")
            }
        
        let confirmAction = UIAlertAction(
            title: "Confirm",
            style: UIAlertAction.Style.default) { _ in
                
                print("Confirm button tapped")
                
                switch UserResult.followingsResults[indexPath.row].friendshipRelation {
                case .friends:
                    cell.changedFriendshipRelation(to: .notFriends)
                    
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        UserResult.followingsResults[indexPath.row].friendshipRelation = .notFriends
                    }
                case .notFriends:
                    cell.changedFriendshipRelation(to: .friends)
                    
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        UserResult.followingsResults[indexPath.row].friendshipRelation = .friends
                    }
                default:
                    break
                }
            }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        cell.actionButton.showAnimation {
            alertController.show()
        }
    }
}

extension FollowingFollowerViewController: SegmentedControlDelegate {
    
    func didIndexChanged(at index: Int) {
        segmentedButtonIndex = index
        collectionView.reloadData()
    }
}
