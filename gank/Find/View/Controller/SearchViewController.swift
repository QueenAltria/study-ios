//
//  SearchViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/13.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SearchViewController: UIViewController {
    
    var tableView:UITableView?
    var searchBar:UISearchBar?
    var gankArray=[GankModel]()
    var searchText:String=""
    var page=1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.view.backgroundColor=UIColor.orange
        self.definesPresentationContext=false
        
        tableView=UITableView(frame: self.view.bounds,style:UITableViewStyle.plain)
        
        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 60))
        searchBar?.setShowsCancelButton(true, animated: true)
        
        self.navigationItem.titleView=searchBar
        
        searchBar?.delegate=self
        searchBar?.searchBarStyle = .default
        searchBar?.becomeFirstResponder()   //直接弹出软键盘
        //tableView?.tableHeaderView = searchBar
        tableView?.separatorStyle=UITableViewCellSeparatorStyle.none
        tableView?.delegate=self
        tableView?.dataSource=self
        tableView?.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView?.rowHeight=100
        
        tableView?.keyboardDismissMode=UIScrollViewKeyboardDismissMode.onDrag   //滑动收起软键盘
        
        self.view.addSubview(tableView!)
        
//        tableView?.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: true)
//        tableView?.es.addPullToRefresh {
//            self.tableView?.es.stopPullToRefresh()
//            print("搜索下拉刷新")
//        }
        
        tableView?.es.addInfiniteScrolling {
            print("搜索上拉加载更多")
            self.loadNet()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar?.resignFirstResponder()    //收起软键盘
    }
    
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchViewController{
    func loadNet(){
        print("开始搜索")
        
        let encodingText=searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let categoryUrl=URL_main+SEARCH+encodingText!+"/category/all/count/10/page/\(page)"
        
        print("url:\(categoryUrl)")
        QMNetworkToolsJson.requestData(.get, URLString: categoryUrl) { (resultJson) in
            
            if !resultJson["error"].boolValue{
                //print("请求成功\(resultJson)")
                
                var currentArray=[GankModel]()
                for jsonItem in resultJson["results"].arrayValue{
                    let gankItem:GankModel=GankModel(jsonData: jsonItem)
                    
                    self.gankArray.append(gankItem)
                    currentArray.append(gankItem)
                }
                
                if(currentArray.count<10){
                    self.tableView?.es.noticeNoMoreData()
                }else{
                    self.tableView?.reloadData()
                    self.page+=1
                    self.tableView?.es.stopLoadingMore()
                }
            }
        }
    }
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gankArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryViewCell
        cell.model=gankArray[indexPath.row]
        return cell
    }
}

extension SearchViewController:UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating{
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText=searchText
        print("textDidChange:\(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //dismiss(animated: true, completion: nil)
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        print("取消按钮点击")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("开始搜索：\(searchText)")
        gankArray=[]
        page=1
        
        tableView?.reloadData()
        tableView?.es.resetNoMoreData()
        
        loadNet()
    }
}
