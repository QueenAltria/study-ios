//
//  ViewExtension.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

private var PERSON_ID_NUMBER_PROPERTY = 0
private var OBJ_ID_NUMBER_PROPERTY = 0

private var Tap_ID_NUMBER_PROPERTY = 0
typealias TapListener = (UITapGestureRecognizer) -> Void;

private var BUTTON_ID_NUMBER_PROPERTY = 0

extension UIView{
    
    private var listener : TapListener{
        get{
            return objc_getAssociatedObject(self, &Tap_ID_NUMBER_PROPERTY) as! TapListener ;
        }
        set(_listener){
            objc_setAssociatedObject(self, &Tap_ID_NUMBER_PROPERTY, _listener, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
            
        }
    };
    
    func setOnTapListener(_ action: @escaping TapListener){
        self.isUserInteractionEnabled = true;
        self.listener = action;
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:  #selector(doOnTapListener(_:))));
    }
    
    
    
    @objc private func doOnTapListener(_ tap:UITapGestureRecognizer){
        self.listener(tap);
    }
    
    
    
    
    
    var tagStr:String?{
        get{
            return objc_getAssociatedObject(self, &PERSON_ID_NUMBER_PROPERTY) as? String;
        }
        set(_str){
            objc_setAssociatedObject(self, &PERSON_ID_NUMBER_PROPERTY, _str, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    };
    
    var obj:Any? {
        get{
            return objc_getAssociatedObject(self, &OBJ_ID_NUMBER_PROPERTY) as Any;
        }
        set(_obj){
            objc_setAssociatedObject(self, &OBJ_ID_NUMBER_PROPERTY, _obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
    

    /**
     
     public var x: CGFloat {
     get {
     return self.frame.origin.x
     }
     set {
     var frame = self.frame
     frame.origin.x = newValue
     self.frame = frame
     }
     }
     
     public var y: CGFloat{
     get {
     return self.frame.origin.y
     }
     set {
     var frame = self.frame
     frame.origin.y = newValue
     self.frame = frame
     }
     }
     
     /** 宽 */
     public var width: CGFloat{
     get {
     return self.frame.size.width
     }
     set {
     var frame = self.frame
     frame.size.width = newValue
     self.frame = frame
     }
     }
     
     /** 高 */
     public var height: CGFloat{
     get {
     return self.frame.size.height
     }
     set {
     var frame = self.frame
     frame.size.height = newValue
     self.frame = frame
     }
     }
     
     /** 下 */
     public var bottom: CGFloat{
     get {
     return self.frame.origin.y + self.frame.size.height
     }
     
     set {
     var frame = self.frame
     frame.origin.y = newValue - self.frame.size.height
     self.frame = frame
     }
     }
     
     /** 右 */
     public var right: CGFloat{
     get {
     return self.frame.origin.x + self.frame.size.width
     }
     
     set {
     var frame = self.frame
     frame.origin.x = newValue - self.frame.size.width
     self.frame = frame
     }
     }
     
     /** 尺寸 */
     public var size: CGSize{
     get {
     return self.frame.size
     }
     
     set {
     var frame = self.frame
     frame.size = newValue
     self.frame = frame
     }
     }
     
     /** 竖直中心对齐 */
     public var centerX: CGFloat{
     get {
     return self.center.x
     }
     
     set {
     var center = self.center
     center.x = newValue
     self.center = center
     }
     }
     
     /** 水平中心对齐 */
     public var centerY: CGFloat{
     get {
     return self.center.y
     }
     
     set {
     var center = self.center
     center.y = newValue
     self.center = center
     }
     }
     
     */
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        let path:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}

extension UIView {
    /// 部分圆角
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setBorder(width:CGFloat,radius:CGFloat,color:UIColor){
        self.layer.borderColor=color.cgColor
        self.layer.borderWidth=width
        self.layer.cornerRadius=radius
        self.layer.masksToBounds=true
    }
}

extension UIImageView{
    convenience init(imgNamed:String){
        self.init(image: UIImage.init(named: imgNamed));
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 3
        rotationAnim.isRemovedOnCompletion = false
        self.layer.add(rotationAnim, forKey: nil)
    }
}

//生成渐变的UIImage
public extension UIImage {
    convenience init?(gradientColors:[CGColor], size:CGSize = CGSize(width: 10, height: 10) ){
        //第三个参数scale  0代表自动缩放  这里直接使用1
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
        let colors = gradientColors as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors , locations: nil)
        // 第二个参数是起始位置，第三个参数是终止位置
        context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
}

extension UIView {
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
