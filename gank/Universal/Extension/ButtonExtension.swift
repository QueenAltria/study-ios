//
//  ButtonListener.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

typealias ButtonListener = (UIButton) -> Void;

private var BUTTON_ID_NUMBER_PROPERTY = 0

extension UIButton {
    
    private var listener : ButtonListener{
        get{
            return objc_getAssociatedObject(self, &BUTTON_ID_NUMBER_PROPERTY) as! ButtonListener ;
        }
        set(_listener){
            objc_setAssociatedObject(self, &BUTTON_ID_NUMBER_PROPERTY, _listener, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    };
    
    
    func setOnClickListener(_ action: @escaping ButtonListener){
        self.listener = action;
        self.removeTarget(self, action: #selector(doOnClickListener), for: .touchUpInside)
        self.addTarget(self, action: #selector(doOnClickListener), for: .touchUpInside);
    }
    
    
    @objc private func doOnClickListener(){
        self.listener(self);
    }
    
    func setRadius(radius:CGFloat){
        self.layer.cornerRadius=radius
        self.layer.masksToBounds=true
    }
}

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
