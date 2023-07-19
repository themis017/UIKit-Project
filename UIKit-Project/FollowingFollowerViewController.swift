//
//  FollowingFollowerViewController.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import UIKit

class FollowingFollowerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, MyCellDelegate {
    
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
    
    private var collectionView: UICollectionView?
    
    private var searchBar: UISearchController = {
            let sb = UISearchController()
            sb.searchBar.placeholder = "Type for search..."
            sb.searchBar.searchBarStyle = .minimal
        
            return sb
        }()
    
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
        
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        collectionView.register(UIUserResultCollectionViewCell.self,
                                forCellWithReuseIdentifier: UIUserResultCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.backgroundColor = .systemGray
        collectionView.frame = view.bounds
        
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
}
