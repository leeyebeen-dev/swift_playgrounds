//
//  ViewController.swift
//  swift-playground
//
//  Created by 이예빈 on 10/15/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipeLeft.direction = .left
        
        for view in swipeableViews {
            view.addGestureRecognizer(swipeRight)
            view.addGestureRecognizer(swipeLeft)
            self.view.addSubview(view)
        }
        
        updateView()
    }
    
    let swipeableViews: [UIView] = [UIView(), UIView(), UIView()] // 각 단계의 뷰를 생성합니다.
    var currentIndex: Int = 0 // 현재 표시되고 있는 뷰의 인덱스를 저장합니다.
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentIndex < swipeableViews.count - 1 {
            currentIndex += 1
            updateView()
        }
    }
    
    @IBOutlet var stepLabel: UILabel!
    
    
    @objc func swipeView(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left && currentIndex < swipeableViews.count - 1 {
            currentIndex += 1
        } else if gesture.direction == .right && currentIndex > 0 {
            currentIndex -= 1
        }
        
        updateView()
    }
    
    func updateView() {
        for (index, view) in swipeableViews.enumerated() {
            view.isHidden = index != currentIndex
        }
        
        // 현재 단계에 맞게 레이블의 텍스트를 갱신합니다.
        stepLabel.text = "단계 \(currentIndex + 1)"
    }
}

