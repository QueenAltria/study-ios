//
//  FindViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    let cellName="categoryViewCell"
    
    var headerViewModer=FindHeaderViewModel.init()
    
    let headerView=FindHeaderView()
    
    var tableView:UITableView?
    
    var progress:UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.edgesForExtendedLayout=UIRectEdge()
        headerView.imageClickDelegate=self
        
        let rightBtn=UIBarButtonItem(title: "搜索", style: UIBarButtonItemStyle.plain, target: self, action: "search")
        navigationItem.rightBarButtonItem=rightBtn
        
        self.view.backgroundColor=UIColor.groupTableViewBackground

        //self.view.addSubview(headerView)
        loadNet()
        
        tableView=UITableView(frame: self.view.bounds,style:UITableViewStyle.grouped)
        tableView?.delegate=self
        tableView?.dataSource=self
        tableView?.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: cellName)
        tableView?.rowHeight=100
        tableView?.separatorStyle=UITableViewCellSeparatorStyle.singleLine
        
        tableView?.tableHeaderView=headerView
        self.view.addSubview(tableView!)
        
        progress=UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        progress?.activityIndicatorViewStyle = .gray
        progress?.startAnimating()
        progress?.center=self.view.center
        self.view.addSubview(progress!)
        
        self.tableView?.es.addInfiniteScrolling {
            self.loadNet()
        }
    }
    
    @objc func search() {
        print("搜索")
        let vc=SearchViewController()
        vc.hidesBottomBarWhenPushed=true
        
        //去除子界面的返回文字
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        
        //self.present(vc, animated: true, completion: nil);   //从下向上
        self.definesPresentationContext=true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FindViewController{
    func loadNet(){
        self.headerViewModer.loadData {
            self.tableView?.reloadData()
            self.tableView?.es.stopLoadingMore()
            
            self.progress?.removeFromSuperview()
        }
    }
}

//点击顶部分类
extension FindViewController:ImageClickDelegate{
    func buttonClick(tag: String) {
        let vc=CategoryViewController()
        vc.categoryString=tag
        vc.title=tag
        vc.hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FindViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerViewModer.gankArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc=WebViewViewController()
        vc.title=headerViewModer.gankArray[indexPath.row].desc
        vc.urlString=headerViewModer.gankArray[indexPath.row].url
        vc.hidesBottomBarWhenPushed=true
        vc.intentModel=headerViewModer.gankArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! CategoryViewCell
        cell.model=headerViewModer.gankArray[indexPath.row]
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = RandomHeaderView()
        view.tag = section
        return view
    }
}
