//
//  UIUserResultCollectionViewCell.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import UIKit

protocol CellActionDelegate: AnyObject {
    func buttonTapped(in cell: UserResultCollectionViewCell)
}

class UserResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    var userResult = UserResult()
    weak var delegate: CellActionDelegate?
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        
        return nameLabel
    }()
    
    let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.textColor = UIColor.lightGray
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        
        return usernameLabel
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.tintColor = UIColor.white
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        button.clipsToBounds = true
        
        return button
    }()
    
    
    let userInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = NSLayoutConstraint.Axis.vertical
        sv.alignment = UIStackView.Alignment.leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    let horizontalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.center
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        userInfoStackView.addArrangedSubview(nameLabel)
        userInfoStackView.addArrangedSubview(usernameLabel)
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(profileImage)
        horizontalStackView.addArrangedSubview(userInfoStackView)
        horizontalStackView.addArrangedSubview(actionButton)
        
        setUpConstrains()
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        delegate?.buttonTapped(in: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure(with user: UserResult) {
        
        self.profileImage.image = user.image
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        
        changedFriendshipRelation(to: user.friendshipRelation)
    }
    
    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //
    //        profileImage.image = nil
    //        nameLabel.text = nil
    //        usernameLabel.text = nil
    //    }
    
    public func changedFriendshipRelation(to friendshipRelation: FriendshipRelation) {
        switch friendshipRelation {
        case .friends:
            actionButton.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            actionButton.setTitle("Friend", for: .normal)
        case .pending:
            actionButton.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            actionButton.setTitle("Pending", for: .normal)
        case .notFriends:
            actionButton.backgroundColor = UIColor.blue
            actionButton.setTitle("Add friend", for: .normal)
        }
    }
    
    private func setUpConstrains() {
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 48),
            profileImage.widthAnchor.constraint(equalToConstant: 48),
            profileImage.rightAnchor.constraint(equalTo: userInfoStackView.leftAnchor, constant: -8),
            
            horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            horizontalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            
            actionButton.heightAnchor.constraint(equalToConstant: 36),
            actionButton.widthAnchor.constraint(equalToConstant: 118)
            
        ])
    }
}
