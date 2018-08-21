//
//  PhotoViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UICollectionViewController {
    
    ///取得的资源结果，用于存放PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>?
    
    ///缩略图大小
    var assetGridThumbnailSize:CGSize!
    
    ///带缓存的图片管理对象
    var imageManager:PHCachingImageManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
 
//        let layout = UICollectionViewFlowLayout.init()
//        layout.itemSize = CGSize(width: kScreenWidth/4, height: kScreenWidth/4)
//        let vc:UICollectionViewController = UICollectionViewController.init(collectionViewLayout: layout)
 
     
        self.collectionView?.register(PhotoViewCell.classForCoder(), forCellWithReuseIdentifier: "PhotoViewCell")
        self.collectionView?.backgroundColor=UIColor.white
        //申请权限
        PHPhotoLibrary.requestAuthorization { (status) in
            if status != .authorized{
                return
            }
            
            //获取所有资源
            let allPhotoOptions=PHFetchOptions()
            //按照创建时间倒序排列
            allPhotoOptions.sortDescriptors=[NSSortDescriptor(key: "creationDate", ascending: false)]
            //只获取图片
            allPhotoOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                     PHAssetMediaType.image.rawValue)
            self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                          options: allPhotoOptions)
            //初始化和重置缓存
            self.imageManager=PHCachingImageManager()
            self.resetCachedAssets()
            
            
            //collectionView 重新加载数据
            DispatchQueue.main.sync {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identify:String = "PhotoViewCell"
        let cell = (self.collectionView?.dequeueReusableCell(
            withReuseIdentifier: identify, for: indexPath))! as! PhotoViewCell
        
        if let asset = self.assetsFetchResults?[indexPath.row] {
            //获取缩略图
            self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize,
                                           contentMode: PHImageContentMode.aspectFill,
                                           options: nil) { (image, nfo) in
                                            //(cell.contentView.viewWithTag(1) as! UIImageView).image = image
                                            
                                            cell.imageView?.image=image
                                            print(image)
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myAsset = self.assetsFetchResults![indexPath.row]
        let vc=ImageDetailViewController()
        vc.myAsset=myAsset
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //根据单元格的尺寸计算缩略图大小
        let scale=UIScreen.main.scale
        let cellSize=(self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        assetGridThumbnailSize=CGSize(width: cellSize.width*scale, height: cellSize.height*scale)
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
