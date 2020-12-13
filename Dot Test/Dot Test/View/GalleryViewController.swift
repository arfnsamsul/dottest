//
//  GalleryViewController.swift
//  Dot Test
//
//  Created by Samsul Arifin on 13/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
import ImageViewer_swift

class GalleryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var galleryItems:[GalleryItem] = []
    var imageURLs:[URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getGallery()
    }
    
    func getGallery() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        MainLoader.getGallery(){ result in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch result {
            case .success(let getGalleryResponse):
                if getGalleryResponse.statusCode == 200 {
                    self.setupView(data: getGalleryResponse.data)
                }else{
                    let alertNotif = MBProgressHUD.showAdded(to: self.view, animated: true)
                    alertNotif.mode = MBProgressHUDMode.text
                    alertNotif.label.text = getGalleryResponse.message
                    alertNotif.hide(animated: true, afterDelay: 3)
                }
             case .failure(let error):
                 print(error.localizedDescription)
            }
        }
    }
    
    func setupView(data:[GalleryItem]){
        galleryItems = data
        imageURLs = galleryItems.map({ URL(string: $0.image)!  })
        collectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        cell.galleryItem.sd_setImage(with: URL(string: galleryItems[indexPath.item].thumbnail))
        
//        // Setup Image Viewer with [URL]
        cell.galleryItem.setupImageViewer(
            urls: self.imageURLs,
            initialIndex: indexPath.item,
            options: [
                .theme(.light),
            ],
            from: self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.size.width-20) / 3;
        return CGSize(width: width, height: width)
    }
    
}

class GalleryCell:UICollectionViewCell {
    @IBOutlet weak var galleryItem: UIImageView!
    
}
