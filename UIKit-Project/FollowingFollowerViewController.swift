//
//  FollowingFollowerViewController.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import UIKit

class FollowingFollowerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, MyCellDelegate, SegmentedControlDelegate {
    
    private var collectionItems: [UserResult] = [
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 1", username: "user_1", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 2", username: "user_2", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 3", username: "user_3", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 4", username: "user_4", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 5", username: "user_5", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 6", username: "user_6", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 7", username: "user_7", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 8", username: "user_8", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 9", username: "user_9", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 10", username: "user_10", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 11", username: "user_11", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 12", username: "user_12", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 13", username: "user_13", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 14", username: "user_14", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 15", username: "user_15", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 16", username: "user_16", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 17", username: "user_17", friendshipRelation: .pending),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 18", username: "user_18", friendshipRelation: .notFriends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 19", username: "user_19", friendshipRelation: .friends),
        UserResult(image: UIImage(named: "default.avatar")!, name: "Full name 20", username: "user_20", friendshipRelation: .pending)
    ]
    
    lazy var segmentedButtonsView: SegmentedButtonsView = {
        
        let segmentedButtonsView = SegmentedButtonsView()
        
        segmentedButtonsView.setLabelsTitles(titles: ["Following", "Followers"])
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        segmentedButtonsView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        segmentedButtonsView.layer.borderColor = UIColor(ciColor: .white).cgColor
        segmentedButtonsView.layer.borderWidth = 0.5
        
        return segmentedButtonsView
        
    }()
    
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Timeline"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = .clear
        s.barStyle = .default
        s.sizeToFit()
        return s
    }()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width / 1.1,
                                 height: view.frame.size.height / 20)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
                
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        //        navigationController?.navigationBar.barTintColor = UIColor.red
//        //        navigationController?.navigationBar.shadowImage = UIImage()
//
//        title = "User";
        
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myView)
        myView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.topAnchor),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
                
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.width),
            label.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        //            searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundImage = UIImage()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        segmentedButtonsView.segmentedControlDelegate = self
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedButtonsView)
        
        NSLayoutConstraint.activate([
            segmentedButtonsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            segmentedButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        collectionView.register(UIUserResultCollectionViewCell.self,
                                forCellWithReuseIdentifier: UIUserResultCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedButtonsView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIUserResultCollectionViewCell.identifier,
                                                      for: indexPath) as! UIUserResultCollectionViewCell
        
        cell.configure(with: collectionItems[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func buttonTapped(in cell: UIUserResultCollectionViewCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else {
            return
        }
        
        print("Button tapped in cell at index: \(indexPath.item)")
            
        let alertController = UIAlertController(title: "Action button info",
                                                message: "You've tapped action button.",
                                                preferredStyle: UIAlertController.Style.alert)
        
        let DestructiveAction = UIAlertAction(title: "Cancel",
                                              style: UIAlertAction.Style.destructive) {
            (result : UIAlertAction) -> Void in
            print("Cancel button tapped")
        }
        
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            
            print("OK button tapped")
            
            switch self.collectionItems[indexPath.row].friendshipRelation {
            case .friends:
                cell.changedFriendshipRelation(to: .notFriends)
                
                if let indexPath = self.collectionView?.indexPath(for: cell) {
                    self.collectionItems[indexPath.row].friendshipRelation = .notFriends
                }
            case .notFriends:
                cell.changedFriendshipRelation(to: .friends)
                
                if let indexPath = self.collectionView?.indexPath(for: cell) {
                    self.collectionItems[indexPath.row].friendshipRelation = .friends
                }
            default:
                break
            }
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        
        cell.actionButton.showAnimation {
            alertController.show()
            //            self.button.style = self.button.style == .secondary ? .primary : .secondary
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func didIndexChanged(at index: Int) {
        
    }
}
