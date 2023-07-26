//
//  SegmentedButtonsView.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import Foundation
import UIKit

protocol SegmentedControlDelegate: AnyObject{
    func segmentedButtonIndexChanged(to index: Int)
}

class SegmentedButtonsView: UIView {
    
    lazy var selectorView = UIView()
    lazy var labels = [UILabel]()
    private var titles: [String]!
    var textColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    public private(set) var selectedIndex: Int = 0
    
    weak var segmentedControlDelegate: SegmentedControlDelegate?
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame:frame)
        self.titles = titles
    }
    
    private func updateView() {
        createLabels()
        configStackView()
        configSelectedTap()
    }
    
    private func createLabels() {
        
        labels.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        
        for labelTitle in titles {
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = labelTitle
            
            let tapGestureRecognizor = UITapGestureRecognizer(target: self, action: #selector(labelActionHandler(sender:)))
            tapGestureRecognizor.numberOfTapsRequired = 1
            label.addGestureRecognizer(tapGestureRecognizor)
            label.isUserInteractionEnabled = true
            
            label.textColor = textColor
            label.textAlignment = .center
            labels.append(label)
        }
        
        labels[0].textColor = selectorTextColor
    }
    
    private func configStackView() {
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)

        ])
    }
    
    private func configSelectedTap() {
        let segmentsCount = CGFloat(titles.count)
        let selectorWidth = UIScreen.main.bounds.width / segmentsCount
        
        selectorView = UIView(frame: CGRect(x: 0, y: 30, width: selectorWidth, height: 2))
        selectorView.backgroundColor = .black
        
        addSubview(selectorView)
    }
        
    func setLabelsTitles(titles: [String]) {
        self.titles = titles
        self.updateView()
    }
    
    @objc private func labelActionHandler(sender: UITapGestureRecognizer) {
        
        for (labelIndex, label) in labels.enumerated() {
            
            if label == sender.view {
                let selectorPosition = (frame.width / CGFloat(titles.count)) * CGFloat(labelIndex)
                selectedIndex = labelIndex
                segmentedControlDelegate?.segmentedButtonIndexChanged(to: selectedIndex)
                
                label.textColor = selectorTextColor
                
                UIView.animate(withDuration: 0.1) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
            } else {
                label.textColor = textColor
            }
        }
    }
    
    func segmentedButtonIndexChanged(to index: Int) {
        if index == 0 {
            labels[0].textColor = selectorTextColor
            labels[1].textColor = textColor
                        
            UIView.animate(withDuration: 0.1) {
                self.selectorView.frame.origin.x = 0
            }
        } else {
            labels[0].textColor = textColor
            labels[1].textColor = selectorTextColor
            
            let selectorPosition = frame.width / CGFloat(titles.count)
            
            UIView.animate(withDuration: 0.1) {
                self.selectorView.frame.origin.x = selectorPosition
            }
        }
    }
}

