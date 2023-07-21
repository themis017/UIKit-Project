//
//  CustomSegmentedControl.swift
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


//
//import Foundation
//import UIKit
//
//class CustomSegmentedControl: UIView {
//
//    private var buttonTitles: [String]!
//    private var buttons: [UIButton]
//    private var selectorView: UIView!
//
//    var textColor: UIColor = .black
//    var selectorViewColor: UIColor = .red
//    var selectorTextColor: UIColor = .red
//
//
//    convenience init(frame: CGRect,
//                     buttonTitles: [String]) {
//
//        self.init(frame: frame)
//        self.buttonTitles = buttonTitles
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func updateView() {
//        createButtons()
//        configStackView()
//        configSelectorView()
//    }
//
//    private func configStackView() {
//        let stack = UIStackView(arrangedSubviews: buttons)
//        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.distribution = .fillEqually
//
//        addSubview(stack)
//
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: self.topAnchor),
//            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            stack.leftAnchor.constraint(equalTo: self.leftAnchor),
//            stack.rightAnchor.constraint(equalTo: self.rightAnchor)
//        ])
//    }
//
//    private func configSelectorView() {
//        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
//
//        selectorView = UIView(frame: CGRect(
//            x: 0,
//            y: self.frame.height,
//            width: selectorWidth,
//            height: 2)
//        )
//
//        selectorView.backgroundColor = selectorViewColor
//        addSubview(selectorView)
//    }
//
//    private func createButtons() {
//        buttons = [UIButton]()
//        buttons.removeAll()
//
//        subviews.forEach({ $0.removeFromSuperview() })
//
//        for buttonTitle in buttonTitles {
//            let button = UIButton(type: .system)
//            button.setTitle(buttonTitle, for: .normal)
//            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
//            button.setTitleColor(textColor, for: .normal)
//            buttons.append(button)
//
//            buttons[0].setTitleColor(selectorTextColor, for: .normal)
//        }
//    }
//
//    @objc func buttonAction(sender: UIButton) {
//        for (buttonIndex, button) in buttons.enumerated() {
//            button.setTitleColor(textColor, for: .normal)
//
//            if button == sender {
//                let selectorPosition = (frame.width / CGFloat(buttonTitles.count)) * CGFloat(buttonIndex)
//
//                UIView.animate(withDuration: 0.3) {
//                    self.selectorView.frame.origin.x = selectorPosition
//                }
//
//                button.setTitleColor(selectorTextColor, for: .normal)
//            }
//        }
//    }
//}
