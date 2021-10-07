//
//  SignUpViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit
import Firebase

protocol SignupViewControllerDelegate {
    func isButtonEnable() -> Bool
}

class SignUpViewController: UIViewController {
    
    let userInfomation: UserInfomation = UserInfomation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomMargin = self.bottomContainerMargin.constant
        addNotification()
    }
    @IBOutlet weak var bottomContainerMargin: NSLayoutConstraint!
    
    private var originalBottomMargin: CGFloat = 0
    
    @IBOutlet var profileImageView: UIImageView! {
        didSet{
            profileImageView.layer.cornerRadius = 50
        }
    }
    @IBOutlet var idTextField: UITextField! {
        didSet{
            idTextField.delegate = self
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet{
//            passwordTextField.textContentType = .newPassword
            passwordTextField.isSecureTextEntry = true
            passwordTextField.delegate = self
        }
    }
    @IBOutlet var nameTextField: UITextField! {
        didSet{
            idTextField.delegate = self
        }
    }
    
    
    @IBOutlet weak var registerDone: UIButton! {
        didSet{
            registerDone.isEnabled = false
        }
    }
    @IBAction func registerButton(_ sender: UIButton) {
        guard let id = idTextField.text else {
            print("id 빔")
            return
        }
        guard let password = passwordTextField.text else {
            print("password 빔")
            return
        }
        guard let profile = profileImageView.image else {
            print("image 빔")
            return
        }
        guard let name = nameTextField.text else {
            print("intro 빔")
            return
        }
        userInfomation.registUserId(id: id)
        userInfomation.registUserPwd(password: password)
        userInfomation.registUserProfile(profile: profile)
        userInfomation.registUserName(name: name)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        return imagePicker
    }()
    
    @IBAction func moveToAlbum(_ sender: UIButton){
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    @IBAction func cancelSignup(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
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
              self.bottomContainerMargin.constant = keyboardHeight - self.view.safeAreaInsets.bottom + 30
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
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.profileImageView.image = editedImage
        }else if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 필드 뿐만 아니라 모든 정보가 입력되야 넘어가게끔 nil 체크 해보자
        if isButtonEnable(){
            registerDone.isEnabled = true
        }else{
            registerDone.isEnabled = false
        }
    }
}


extension SignUpViewController : SignupViewControllerDelegate {
    
    // 입력란이 모두 유효한지 체크 func
    func isButtonEnable() -> Bool {
        if idTextField.text != "" && profileImageView.image != nil && nameTextField.text != "" && passwordTextField.text != ""{
            return true
        }
        return false
    }
}
