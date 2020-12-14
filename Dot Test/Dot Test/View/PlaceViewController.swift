//
//  PlaceViewController.swift
//  Dot Test
//
//  Created by Samsul Arifin on 12/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
class PlaceViewController: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var placeResponse:PlaceResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPlace()
    }
    
    func getPlace() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        MainLoader.getPlace(){ result in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch result {
            case .success(let getPlaceResponse):
                if getPlaceResponse.statusCode == 200 {
                    self.setupView(data: getPlaceResponse.data)
                }else{
                    let alertNotif = MBProgressHUD.showAdded(to: self.view, animated: true)
                    alertNotif.mode = MBProgressHUDMode.text
                    alertNotif.label.text = getPlaceResponse.message
                    alertNotif.hide(animated: true, afterDelay: 3)
                }
             case .failure(let error):
                 print(error.localizedDescription)
            }
        }
    }
    
    func setupView(data: PlaceResponse){
        placeResponse = data
        tableView.reloadData()
        lblHeader.text = placeResponse?.header.title ?? ""
        lblSubHeader.text = placeResponse?.header.subtitle ?? ""
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

extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeResponse?.content.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentItem = placeResponse?.content[indexPath.row] else { return UITableViewCell() }
        
        if currentItem.type == "multiple" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceMultipleCell", for: indexPath) as! PlaceMultipleCell
             
            cell.lblTitle.text = currentItem.title
            cell.lblContent.text = currentItem.content
            cell.imagesUrl = currentItem.media
            cell.setupScroll()
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
             
            cell.lblTitle.text = currentItem.title
            cell.lblContent.text = currentItem.content
            if let img = currentItem.image {
                cell.imgMedia.sd_setImage(with: URL(string: img))
            } else {
                cell.imgMedia.sd_setImage(with: URL(string: currentItem.media.first ?? ""))
            }
            return cell
        }
    }
    
    
}

class PlaceCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imgMedia: UIImageView!
    
}

class PlaceMultipleCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imagesUrl:[String] = []
    func setupScroll() {
        var frame = CGRect.zero
        let width:CGFloat = scrollView.frame.size.width * 0.8
        let space:CGFloat = 8.0
        
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        for index in 0..<imagesUrl.count {
            frame.origin.x = (width + space) * CGFloat(index)
            frame.size = CGSize(width: width, height: scrollView.frame.height)

            let containerView = UIView(frame: frame)
            self.scrollView.addSubview(containerView)
            
            let imgView = UIImageView()
            imgView.sd_setImage(with: URL(string: imagesUrl[index]))
            imgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            imgView.contentMode = .scaleAspectFill
            imgView.layer.cornerRadius = 8
            imgView.clipsToBounds = true
            containerView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (width + space) * CGFloat(imagesUrl.count), height: scrollView.frame.size.height)
    }
}
