//
//  LoginViewController.swift
//  Instagram
//
//  Created by 入子優哉 on 2020/03/29.
//  Copyright © 2020 yuya.iriko. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleLoginButton(_ sender: Any) {
        //アンラップ処理
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            //空文字識別
            if address.isEmpty || password.isEmpty {
                return
            }
            Auth.auth().signIn(withEmail: address, password: password){authResult, error in
                if let error = error {
                    print("DEBUG:ログインエラー" + error.localizedDescription)
                    return
                }
                print("DEBUG:ログイン完了")
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        
        //アンラップ処理、入力された文字を変数に代入して扱いやすくしている
        if let address = mailAddressTextField.text, let  password = passwordTextField.text, let displayName = displayNameTextField.text{
        //空文字識別
            if address.isEmpty || password.isEmpty || displayName.isEmpty{
                print("DEBUG:何かが空文字です")
                return
            }
            //ユーザー作成(メールアドレスとパスワード設定)
            Auth.auth().createUser(withEmail: address, password: password ) { authResult, error in
                if let error = error {
                    print("DEBUG:ユーザー作成時エラー" + error.localizedDescription)
                    return
                }
                //・・・・・・・・・・・ここで自動にログイン・・・・・・・・・・・・
                print("DEBUG:ユーザー作成完了")
                //ユーザー作成(表示名設定)
                let user = Auth.auth().currentUser //上の処理で作成したアカウントを呼び出し
                    if let user = user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = displayName
                            changeRequest.commitChanges { error in
                                if let error = error {
                                    print("DEBUG:プロフィール更新時エラー" + error.localizedDescription)
                                    return
                                    }
                                    print("DEBUG:[displayName = \(user.displayName!)の設定が完了]")
                                    self.dismiss(animated: true, completion: nil)
                                    }
                                }
                }
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
