//
//  HomeViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

fileprivate let homeListCell:String="homeListCell"

class HomeViewController: UIViewController {
    
    let headerView=HomeHeadView()
    var tableView:UITableView?
    var homePageViewModel=HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.edgesForExtendedLayout=UIRectEdge()
        setupUI()
        loadDataNow(firstLoad: true)
        
        launchAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController{
    private func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
}

extension HomeViewController{
    func setupUI() -> Void {
        navigationItem.title="Gank.io"
        
        let right=UIBarButtonItem(title: "网站数据", style: UIBarButtonItemStyle.plain, target: self, action: "date")
        self.navigationItem.rightBarButtonItem=right

        tableView=UITableView(frame: self.view.bounds,style:UITableViewStyle.grouped)
        tableView?.delegate=self
        tableView?.dataSource=self
        
        tableView?.register(UINib.init(nibName: "HomeListCell", bundle: nil), forCellReuseIdentifier: homeListCell)
        //tableView?.rowHeight=180
        
        //设置一个差不多的值
        tableView?.estimatedRowHeight = 50
        //设置自适应
        tableView?.rowHeight=UITableViewAutomaticDimension
        
        tableView?.backgroundColor=UIColor.white
        tableView?.sectionHeaderHeight=50
        tableView?.sectionFooterHeight=0.00001
        tableView?.separatorStyle=UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView!)
        
        tableView?.tableHeaderView=headerView
        
    }
    
    @objc func date(){
        let vc=DateViewController()
        vc.hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - 网络加载
extension HomeViewController{
    func loadDataNow(firstLoad:Bool) {
        homePageViewModel.loadHomePageData{
            self.tableView?.reloadData()
            self.headerView.gankItem=self.homePageViewModel.fuliItem
        }
    }
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.homePageViewModel.homeArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homePageViewModel.homeArray[section].model.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIButton(type: UIButtonType.roundedRect)
//        view.frame = CGRect(x: 10*proportionWidth, y: 0.0, width: kScreenWidth-20*proportionWidth, height: 40*proportionWidth)
//        view.backgroundColor = UIColor.white
//        view.setTitle(self.homePageViewModel.homeArray[section].type, for: UIControlState())
//        view.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
//        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        view.titleLabel?.textColor = UIColor.black
//        view.tag = section
        
        let  view = GroupHeaderView()
        view.titleText=self.homePageViewModel.homeArray[section].type
        view.updateUI()
        view.tag=section
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
            
            let itemType : String = self.homePageViewModel.homeArray[indexPath.section].type
            
        let itemArray  = self.homePageViewModel.homeArray[indexPath.section].model
            
            if itemType == "Android" {//课程
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell;
            }
            if itemType == "iOS" {//活动
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell
            }
            if itemType == "休息视频" {//视频
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell
            }
            if itemType == "前端" {//师资
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell;
            }
            if itemType == "拓展资源" {//分院
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell
            }
            
            if itemType == "福利"  {//快讯
                let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
                cell.model=itemArray[indexPath.row]
                cell.selectionStyle = UITableViewCellSelectionStyle.gray
                
                return cell;
            }
        
        if itemType == "App"  {//快讯
            let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
            cell.model=itemArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.gray
            
            return cell;
        }
        
    
        if itemType == "瞎推荐"  {//快讯
            let cell = tableView.dequeueReusableCell(withIdentifier: homeListCell, for: indexPath) as! HomeListCell
            cell.model=itemArray[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.gray
            
            return cell;
        }
            
            let identifer = "identifer"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifer)
            }
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = UITableViewCellSelectionStyle.gray
            return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemType : String = self.homePageViewModel.homeArray[indexPath.section].type
        
        let itemArray  = self.homePageViewModel.homeArray[indexPath.section].model
        
        let vc=WebViewViewController()
        vc.title=itemArray[indexPath.row].desc
        vc.urlString=itemArray[indexPath.row].url
        vc.intentModel=itemArray[indexPath.row]
        vc.hidesBottomBarWhenPushed=true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

