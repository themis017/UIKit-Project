//
//  UISearchView.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 20/7/23.
//

import Foundation
import UIKit

class UISearchView: UIView {
    
    lazy var searchTextField: UISearchTextField = {
       let searchTextField = UISearchTextField()
        searchTextField.text = "Search"
        searchTextField.textColor = .lightGray
        
        return searchTextField
    }()
    
    let textField = UITextField()
    
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        configUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - config ui
    
    private func configUI(){
        addSubview(searchTextField)
                
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.leftAnchor.constraint(equalTo: leftAnchor,constant: 8).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor,constant: 8).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: rightAnchor,constant: -8).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8).isActive = true
    }

    
    
}
