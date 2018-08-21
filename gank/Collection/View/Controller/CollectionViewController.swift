//
//  CollectionViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import SwiftyJSON

class CollectionViewController: UIViewController {
    
    var cellName:String="categoryViewCell"
    var tableView:UITableView?
    var gankArray:[GankModel]?
    var refreshCh:RefreshCt?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.groupTableViewBackground
        
        let emptyView=UILabel()
        emptyView.frame=CGRect(x: 0, y: 0, width: kScreenWidth, height: 30)
        emptyView.text="您还没有任何收藏数据,找篇文章收藏吧~"
        emptyView.textAlignment=NSTextAlignment.center
        emptyView.textColor=UIColor.lightGray
        emptyView.font=UIFont.systemFont(ofSize: 14)
        emptyView.center=self.view.center
        self.view.addSubview(emptyView)
        
        refreshCh=RefreshCt.share()
        refreshCh?.reDelagate=self
        setupUI()
        
        regRefresh()
    }
    
    func setupUI(){
        gankArray=SqlManager.shared.selectAll()
        tableView=UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView?.delegate=self
        tableView?.dataSource=self
        tableView?.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: cellName)
        tableView?.rowHeight=100
        tableView?.separatorStyle=UITableViewCellSeparatorStyle.singleLine
        tableView?.tableFooterView=UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0))  //覆盖掉多余的横线
        self.view.addSubview(tableView!)
        
        tableView?.autoShowEmptyView(dataSourceCount: gankArray?.count)
    }
    
    func regRefresh(){
        NotificationCenter.default.addObserver(self, selector: "refresh", name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    //利用通知更新
    @objc func refresh(){
        gankArray=SqlManager.shared.selectAll()
        print("点击收藏，刷新界面：\(gankArray?.count)")
        tableView?.reloadData()
        
        tableView?.autoShowEmptyView(dataSourceCount: gankArray?.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//刷新
extension CollectionViewController:RefreshCollectioDelegate{
    func reload() {
        /**
        gankArray=SqlManager.shared.selectAll()
        print("点击收藏，刷新界面：\(gankArray?.count)")
        tableView?.reloadData()
        **/
    }
}


extension CollectionViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (gankArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! CategoryViewCell
        
        cell.model=gankArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            print("delete button tapped")
            
            SqlManager.shared.remove(_id: self.gankArray![index.row]._id!)
            self.gankArray?.remove(at: index.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            tableView.autoShowEmptyView(dataSourceCount: self.gankArray?.count)
        }
        delete.backgroundColor = UIColor.red
        
        let share = UITableViewRowAction(style: .normal, title: "分享") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = UIColor.lightGray
        
        return [delete,share]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
    //只有一个删除的话 直接使用以下即可
    /**
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            SqlManager.shared.remove(_id: self.gankArray![indexPath.row]._id!)
            gankArray?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
     **/
}

extension UITableView {
    func autoShowEmptyView(dataSourceCount:Int?){
        self.autoShowEmptyView(title: nil, image: nil, dataSourceCount: dataSourceCount)
    }
    
    func autoShowEmptyView(title:String?,image:UIImage?,dataSourceCount:Int?){
        //guard 类似if语句
        guard let count = dataSourceCount else {
            let empty = EmptyView.init(frame: self.bounds)
            empty.setEmpty(title: title, image: image)
            self.backgroundView = empty
            return
        }
        
        if count == 0 {
            let empty = EmptyView.init(frame: self.bounds)
            empty.setEmpty(title: title, image: image)
            self.backgroundView = empty
        } else {
            self.backgroundView = nil
        }
    }
}
