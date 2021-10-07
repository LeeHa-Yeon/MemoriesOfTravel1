//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField! {
        didSet{
            idTextField.delegate = self
        }
    }
    @IBOutlet weak var pwdTextField: UITextField! {
        didSet{
            pwdTextField.delegate = self
//            pwdTextField.textContentType = .newPassword
//            pwdTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var bottomContainerMargin: NSLayoutConstraint!
    
    private var originalBottomMargin: CGFloat = 0
    let userInfomation: UserInfomation = UserInfomation.shared
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomMargin = self.bottomContainerMargin.constant
        addNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if userInfomation.getUserId() != "" {
            idTextField.text = userInfomation.getUserId()
        }
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keyboardHeight = keyboardFrame.cgRectValue.height
          let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
          UIView.animate(withDuration: animationDuration){
              self.bottomContainerMargin.constant = keyboardHeight - self.view.safeAreaInsets.bottom
              self.view.layoutIfNeeded()
          }
        }
    }
      
    @objc private func keyboardWillHide(_ notification: Notification) {
        let animvationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animvationDuration) {
            self.bottomContainerMargin.constant = self.originalBottomMargin
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }


    @IBAction func moveToHome(_ sender: UIButton) {
//        if let HomeVC = UIStoryboard(name:"Main",bundle: nil).instantiateViewController(identifier: "HomeSB") as? HomeViewController {
//            view.addSubview(HomeVC.view)
//            HomeVC.didMove(toParent: self)
//        }
    }
    
    @IBAction func moveToSignUp(_ sender: UIButton){
//        if let SignUpVC = UIStoryboard(name:"Main",bundle: nil).instantiateViewController(identifier: "SingUpSB") as? SignUpViewController {
//            view.addSubview(SignUpVC.view)
//            SignUpVC.didMove(toParent: self)
//        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
