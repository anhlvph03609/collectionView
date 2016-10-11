//
//  ViewController.swift
//  demoCollectionView
//
//  Created by Anh Lê Việt on 10/10/16.
//  Copyright © 2016 Anh Lê Việt. All rights reserved.
//

import UIKit
import Photos
class ViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        grabPhotos()
    }
    
    
    
    func grabPhotos(){
        let imgManager  = PHImageManager.default()
                let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        
        let fetchOptions  = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate",ascending : false)]
        
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image,options : fetchOptions){
            if  fetchResult.count > 0 {
            
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 250, height:250), contentMode: .aspectFill, options: options, resultHandler:{
                        image,error in
                        self.imageArray.append(image!)
                        
                    } )
                }
            }
            
            else {
                print("No Photo!")
                self.collectionView?.reloadData()
                //grabPhotos()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
    
        imageView.image =  imageArray[indexPath.row]
        return cell
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 - 1
        return CGSize(width:width,height:width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertMessage = UIAlertController(title: "Delete", message: "Do you want to delete this photo?", preferredStyle: .alert)
        let logoAlert = UIImageView(frame: CGRect(x:0,y:-50,width: 300,height: 300))
        logoAlert.image = imageArray[indexPath.row]
        logoAlert.contentMode = .scaleAspectFill
        let actionYes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:  { action in
            self.imageArray.remove(at: indexPath.row)
            self.collectionView?.deleteItems(at: [indexPath])
            
        })
        let actionNo = UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler:  { action in
            
        })
        //alertMessage.addAction(actionYes)
       // alertMessage.addAction(actionNo)
        alertMessage.view.addSubview(logoAlert)
        
      //  alertMessage.setValue(imageArray[indexPath.row], forKey: "image")
        self.present(alertMessage, animated: true, completion:nil)
       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var selectedIndex = collectionView?.indexPath(for: sender as! UICollectionViewCell)
        
        let select : Int! = selectedIndex?.row
        let imageData = UIImagePNGRepresentation(imageArray[select])
        UserDefaults.standard.set(imageData , forKey: "img")
    }
}


