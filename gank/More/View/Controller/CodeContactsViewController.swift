//
//  CodeContactsViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import Contacts

class CodeContactsViewController: UIViewController {
    var strArray=[String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white

        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
            if isRight {
                //授权成功加载数据
                DispatchQueue.main.async {
                    let tableView=UITableView(frame: self.view.bounds)
                    tableView.dataSource=self
                    tableView.delegate=self
                    tableView.tableFooterView=UIView()
                    self.view.addSubview(tableView)
                    
                    self.loadContactsData(tableView)
                }
            
            }else{
                //没有授权
                DispatchQueue.main.async {
                    let empty=EmptyView(frame: self.view.bounds)
                    empty.setEmpty(title: "请先开启访问联系人权限", image: UIImage(named: ""))
                    self.view.addSubview(empty)
                }
            }
        }
    }
    
    func loadContactsData(_ tableView:UITableView) {
        //获取授权状态
        let status=CNContactStore.authorizationStatus(for: .contacts)
        //判断当前授权状态
        guard status == .authorized else {
            return
        }
        //创建通讯录对象
        let store=CNContactStore()
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys=[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                  CNContactOrganizationNameKey, CNContactJobTitleKey,
                  CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                  CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                  CNContactDatesKey, CNContactInstantMessageAddressesKey]
        //创建请求对象
        let request=CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        //遍历所有人
        do{
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                
                //获取姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
                print("姓名：\(lastName)\(firstName)")
                
                //获取昵称
                let nikeName = contact.nickname
                print("昵称：\(nikeName)")
                
                //获取公司（组织）
                let organization = contact.organizationName
                print("公司（组织）：\(organization)")
                
                //获取职位
                let jobTitle = contact.jobTitle
                print("职位：\(jobTitle)")
                
                //获取部门
                let department = contact.departmentName
                print("部门：\(department)")
                
                //获取备注
                let note = contact.note
                print("备注：\(note)")
                
                //获取电话号码
                print("电话：")
                for phone in contact.phoneNumbers {
                    //获得标签名（转为能看得懂的本地标签名，比如work、home）
                    var label = "未知标签"
                    if phone.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:
                            phone.label!)
                    }
                    
                    //获取号码
                    let value = phone.value.stringValue
                    print("\t\(label)：\(value)")
                }
                
                //获取Email
                print("Email：")
                for email in contact.emailAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if email.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:
                            email.label!)
                    }
                    
                    //获取值
                    let value = email.value
                    print("\t\(label)：\(value)")
                }
                
                //获取地址
                print("地址：")
                for address in contact.postalAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if address.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:
                            address.label!)
                    }
                    
                    //获取值
                    let detail = address.value
                    let contry = detail.value(forKey: CNPostalAddressCountryKey) ?? ""
                    let state = detail.value(forKey: CNPostalAddressStateKey) ?? ""
                    let city = detail.value(forKey: CNPostalAddressCityKey) ?? ""
                    let street = detail.value(forKey: CNPostalAddressStreetKey) ?? ""
                    let code = detail.value(forKey: CNPostalAddressPostalCodeKey) ?? ""
                    let str = "国家:\(contry) 省:\(state) 城市:\(city) 街道:\(street)"
                        + " 邮编:\(code)"
                    print("\t\(label)：\(str)")
                }
                
                //获取纪念日
                print("纪念日：")
                for date in contact.dates {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if date.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:
                            date.label!)
                    }
                    
                    //获取值
                    let dateComponents = date.value as DateComponents
                    let value = NSCalendar.current.date(from: dateComponents)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
                    print("\t\(label)：\(dateFormatter.string(from: value!))")
                }
                
                //获取即时通讯(IM)
                print("即时通讯(IM)：")
                for im in contact.instantMessageAddresses {
                    //获得标签名（转为能看得懂的本地标签名）
                    var label = "未知标签"
                    if im.label != nil {
                        label = CNLabeledValue<NSString>.localizedString(forLabel:
                            im.label!)
                    }
                    
                    //获取值
                    let detail = im.value
                    let username = detail.value(forKey: CNInstantMessageAddressUsernameKey)
                        ?? ""
                    let service = detail.value(forKey: CNInstantMessageAddressServiceKey)
                        ?? ""
                    print("\t\(label)：\(username) 服务:\(service)")
                }
                print("----------------")
                
                self.strArray.append("姓名：\(firstName)\(lastName)")
            })
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CodeContactsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text=strArray[indexPath.row]
        return cell
    }
}
