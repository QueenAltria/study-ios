//
//  CategoryViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class CategoryViewController: UIViewController {
    
    var categoryViewCell:String="categoryViewCell"
    
    var categoryString:String?
    var tableView:UITableView?
    var categoryModel:CategoryListModel?
    var page=1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        categoryModel=CategoryListModel(category: categoryString!, pageSize: page)
        
        setupUI()
        loadNet()
    }
    
    func setupUI() {
        tableView=UITableView(frame: self.view.bounds,style:UITableViewStyle.plain)
        
        tableView?.delegate=self
        tableView?.dataSource=self
        
        tableView?.register(UINib.init(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: categoryViewCell)
    
        tableView?.rowHeight=100
        
        tableView?.separatorStyle=UITableViewCellSeparatorStyle.none
        
        self.view.addSubview(tableView!)
        
        tableView?.es.addInfiniteScrolling {
            print("上拉加载更多")
            self.page+=1
            
            self.categoryModel?.pageSize="\(self.page)"
            
            print(self.categoryModel?.pageSize)
            self.loadNet()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CategoryViewController{
    func loadNet() {
        categoryModel?.loadData {
            if (self.categoryModel?.currentArray?.count)!>0 {
                self.tableView?.es.stopLoadingMore()
                self.tableView?.reloadData()
            }else{
                self.tableView?.es.noticeNoMoreData()
            }
        }
    }
}

extension CategoryViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.categoryModel?.gankArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: categoryViewCell, for: indexPath) as! CategoryViewCell
        
        cell.model=self.categoryModel?.gankArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc=WebViewViewController()
        vc.urlString=self.categoryModel?.gankArray[indexPath.row].url
        vc.hidesBottomBarWhenPushed=true
        vc.title=self.categoryModel?.gankArray[indexPath.row].desc
        vc.intentModel=self.categoryModel?.gankArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //设置cell的显示动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
}
