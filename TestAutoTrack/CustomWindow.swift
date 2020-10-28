//
//  CustomWindow.swift
//  TestAutoTrack
//
//  Created by name name on 2017/10/23.
//  Copyright © 2017年 name name. All rights reserved.
//

import UIKit

class CustomWindow: UIWindow {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        
        // TODO 何故か二回呼ばれるので、一回にして下呼ぶ。
        self.trackView(view: hitTestView!)
        
        return hitTestView === self ? nil : hitTestView
    }
    
    func trackView(view:UIView) {
        print(view.description)
        if let tapLbl = view as? UILabel {
            print(tapLbl.text ?? "")
        }
        if let tapBtn = view as? UIButton {
            print(tapBtn.titleLabel?.text ?? "")
        }
        if let tapCell = view as? UITableViewCell {
            print(tapCell.textLabel?.text ?? "")
        }
        if let tapCell = view as? UICollectionViewCell {
            if let image = tapCell.contentView as? UIImageView {
                print(image.image?.description ?? "")
            }
        }
        if let tapSeg = view as? UISegmentedControl {
            print(tapSeg.titleForSegment(at: tapSeg.selectedSegmentIndex) ?? "")
        }
        if let tapSw = view as? UISwitch {
            print(tapSw.isOn)
        }
        if let textField = view as? UITextField {
            print(textField.text ?? "")
        }
        
        let classStr = String(describing: type(of: view))
        
        if classStr == "_UIAlertControllerActionView" {
            //UIAlertButton
            
            let title = view.value(forKey: "_label") as! UILabel
            print(title.text ?? "")
        }
        
        if classStr == "_UIButtonBarButton" {
            //uinavigationBar Item
            
            let back = view.value(forKey: "_backButton") as! Bool
            if back {
                print("_backButton")
            }else{
                for viewi in view.subviews {
                    let classStr = String(describing: type(of: viewi))
                    if classStr == "_UIModernBarButton" {
                        let title = viewi.value(forKey: "titleLabel") as! UILabel
                        print(title.text ?? "")
                    }
                }
            }
            
        }
        if classStr == "UITabBarButton" {
            //UITabBarItem
            
            for viewi in view.subviews {
                let classStr = String(describing: type(of: viewi))
                if classStr == "UITabBarButtonLabel" {
                    let title = viewi.value(forKey: "text")
                    print(title ?? "")
                }
            }
        }
    }
}

