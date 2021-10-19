//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    let firebaseManager = FirebaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomMargin = self.bottomContainerMargin.constant
        addNotification()
//        firebaseManager.updateArrTest()
//        firebaseManager.arrTest()
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(true)
        idTextField.text = ""
        pwdTextField.text = ""
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField! {
        didSet{
            idTextField.delegate = self
        }
    }
    @IBOutlet weak var pwdTextField: UITextField! {
        didSet{
            pwdTextField.delegate = self
        }
    }
    
    @IBOutlet weak var bottomContainerMargin: NSLayoutConstraint!
    private var originalBottomMargin: CGFloat = 0
    
    
    // 키보드 구현
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
    
    // Todo : 로그인 성공했을 경우 홈화면으로 이동, 해당 사용자 정보 디비에서 불러와 저장하기 , 실패했을 경우 경고창으로 알려줌
    @IBAction func moveToHome(_ sender: UIButton) {
        guard let id = idTextField.text else { return }
        guard let password = pwdTextField.text else { return }
        firebaseManager.emailLogin(id: id, password: password) { response in
            guard let response = response else {
                print("로그인 실패")
                return
            }
            self.myInformation.setUserInfo(response)
            
            guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeSB") as? ViewController
            else { return }
            self.present(HomeVC,animated: true, completion: nil)
        }
    }
    
    @IBAction func moveToSignUp(_ sender: UIButton){
        if let SingUpVC = self.storyboard?.instantiateViewController(identifier: "SingUpSB") {
            self.present(SingUpVC,animated: true, completion: nil)
        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
