//
//  SearchController.swift
//  gank
//
//  Created by wangxl on 2018/7/16.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }

    func setupUI(){
        self.view.backgroundColor=UIColor.orange
        self.definesPresentationContext=false
        
        tableView=UITableView(frame: self.view.bounds)
        
        let searchController = UISearchController.init(searchResultsController: self)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation=true
        
        searchController.searchResultsUpdater=self
        searchController.delegate=self
        
        //searchController.animationEnded(true)
        
        let searchBar = searchController.searchBar
        //searchBar.showsCancelButton=true
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.delegate=self
        searchBar.searchBarStyle = .default
        
        //searchBar.setValue("取消", forKey: "_cancelButtonText")
        //通过遍历修改
        /**
        for subview in searchBar.subviews {
            for tempView in subview.subviews{
                if tempView.isKind(of: UIButton.self){
                    let btn=tempView as! UIButton
                    btn.setTitle("取消", for: UIControlState.normal)
                }
            }
        }
        **/

        tableView?.tableHeaderView = searchBar
        self.view.addSubview(tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchController:UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要开始编辑时的回调")
        return true   //false则不能编辑
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("已经开始编辑时的回调")
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要结束编辑时的回调")
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("已经结束编辑的回调")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //编辑文字改变前的回调，返回NO则不能加入新的编辑文字
        print("range:\(range)------text:\(text)")
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
        print("取消按钮点击")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search")
    }
}
