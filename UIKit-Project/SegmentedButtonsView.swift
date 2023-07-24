//
//  SegmentedButtonsView.swift
//  UIKit-Project
//
//  Created by Themis Makedas on 19/7/23.
//

import Foundation
import UIKit

protocol CollectionViewDidScrollDelegate: AnyObject {
    func collectionViewDidScroll(for x: CGFloat)
    
}
protocol SegmentedControlDelegate: AnyObject{
    func didIndexChanged(at index: Int)
}

class SegmentedButtonsView: UIView, CollectionViewDidScrollDelegate {
    
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
        let selectorWidth = self.frame.width / segmentsCount
        
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.8, width: selectorWidth, height: 0.5))
        selectorView.backgroundColor = .black
        
        addSubview(selectorView)
    }
        
    func setLabelsTitles(titles: [String]) {
        self.titles = titles
        self.updateView()
    }
    
    @objc private func labelActionHandler(sender: UITapGestureRecognizer) {
        
        for (labelIndex, lbl) in labels.enumerated() {
            
            if lbl == sender.view {
                let selectorPosition = (frame.width / CGFloat(titles.count)) * CGFloat(labelIndex)
                selectedIndex = labelIndex
                //todo set delegate
                segmentedControlDelegate?.didIndexChanged(at: selectedIndex)
                UIView.animate(withDuration: 0.1) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
            }
        }
    }
}

extension SegmentedButtonsView {
    
    func collectionViewDidScroll(for x: CGFloat) {
        
        UIView.animate(withDuration: 0.1) { [self] in
            self.selectorView.frame.origin.x = x
            
            
            for (_, view) in subviews.enumerated() {
                
                
                if view is UIStackView {
                    
                    guard let stack = view as? UIStackView else {
                        return
                    }
                    
                    
                    for (_, label) in stack.arrangedSubviews.enumerated() {
                        
                        guard let label = label as? UILabel else {
                            print("Error ")
                            return
                        }
                        
                        if  (label.frame.width / 2  >= self.selectorView.frame.origin.x && titles[0] == label.text! || label.frame.width / 2  <= self.selectorView.frame.origin.x && titles[1] == label.text! ) {
                            
                            label.textColor = selectorTextColor
                            
                        } else {
                            label.textColor = textColor
                        }
                    }
                }
            }
        }
    }
    
    func didIndexChanged(at index: Int) {
        
    }
}
