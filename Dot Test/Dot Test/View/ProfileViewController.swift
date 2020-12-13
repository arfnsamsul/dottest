//
//  ProfileViewController.swift
//  Dot Test
//
//  Created by Samsul Arifin on 13/12/20.
//  Copyright © 2020 Samsul Arifin. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getProfile()
    }

    func getProfile() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        MainLoader.getProfile(){ result in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch result {
            case .success(let getProfileResponse):
                if getProfileResponse.statusCode == 200 {
                    self.setupView(data: getProfileResponse.data)
                }else{
                    let alertNotif = MBProgressHUD.showAdded(to: self.view, animated: true)
                    alertNotif.mode = MBProgressHUDMode.text
                    alertNotif.label.text = getProfileResponse.message
                    alertNotif.hide(animated: true, afterDelay: 3)
                }
             case .failure(let error):
                 print(error.localizedDescription)
            }
        }
    }
    
    func setupView(data: Profile) {
        imgAvatar.sd_setImage(with: URL(string: data.avatar))
        lblUserName.text = data.username
        lblFullName.text = data.fullname
        lblEmail.text = data.email
        lblPhone.text = data.phone
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
