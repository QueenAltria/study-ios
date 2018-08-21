//
//  FindHeaderView.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation

import UIKit

protocol ImageClickDelegate : NSObjectProtocol {
    func buttonClick(tag : String)
}

class FindHeaderView:UIView {
    
    weak var imageClickDelegate:ImageClickDelegate?
    
    var categoryListCell:String="CategoryListCell"
    var headerIdentifier:String="headerIdentifier"
    var footerIdentifier:String="footerIdentifier"
    
    var collectionView:UICollectionView!
    
    var findHeaderModel=FindHeaderViewModel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.groupTableViewBackground
        self.frame=CGRect(x: 0, y: 20, width: kScreenWidth, height: 240)
        setupUI()
    }
    
    func setupUI() {
        
        findHeaderModel=FindHeaderViewModel.init()
        
        //设置layout
        let layout=UICollectionViewFlowLayout()
        layout.scrollDirection=UICollectionViewScrollDirection.vertical
        layout.itemSize=CGSize(width: ((kScreenWidth-40)/4), height: 100)
        //设置collectionView
        collectionView=UICollectionView(frame: self.layer.bounds, collectionViewLayout: layout)
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.backgroundColor=UIColor.white
        
        //TODO 这种方式不行
        //collectionView.register(CategoryListCell.self, forCellWithReuseIdentifier: categoryListCell)

        collectionView.register(UINib(nibName: "CategoryListCell", bundle: nil), forCellWithReuseIdentifier: categoryListCell)
        
        //注册一个头部
        collectionView.register(CollectionReusableViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FindHeaderView:UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("findHeaderModel.categoryArray.count\(findHeaderModel.categoryArray.count)")
        
        return findHeaderModel.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: categoryListCell, for: indexPath) as! CategoryListCell
        cell.model=findHeaderModel.categoryArray[indexPath.row]
        
        //cell.categoryLabel.text=findHeaderModel.categoryArray[indexPath.row].categoryName
        
        print("category:\(findHeaderModel.categoryArray[indexPath.row].categoryName)")
    
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(findHeaderModel.categoryArray[indexPath.row].categoryName)
        imageClickDelegate?.buttonClick(tag: findHeaderModel.categoryArray[indexPath.row].categoryName)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!
        
        if kind == UICollectionElementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionReusableViewHeader
            reusableview.backgroundColor = UIColor.groupTableViewBackground
        }
        else if kind == UICollectionElementKindSectionFooter{
            
        }
        
        return reusableview
    }
    
    //返回header的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: 20)
    }
}
