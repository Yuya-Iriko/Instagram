//
//  SettingViewController.swift
//  Instagram
//
//  Created by 入子優哉 on 2020/03/29.
//  Copyright © 2020 yuya.iriko. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBAction func handleChangeUserName(_ sender: Any) {
        if let displayName = userNameTextField.text {
            
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "ユーザー名を入力して下さい")
                return
            }
            
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "ユーザー名の変更に失敗しました。")
                        print("DEBUG:ユーザー名変更失敗" + error.localizedDescription)
                    }
                    print("DEBUG: ユーザー名変更完了")
                    
                    SVProgressHUD.showSuccess(withStatus: "ユーザー名を変更しました！")
                }
            }
        }
        self.view.endEditing(true)
        
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        tabBarController?.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = Auth.auth().currentUser
        if let user = user {
            userNameTextField.text = user.displayName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
