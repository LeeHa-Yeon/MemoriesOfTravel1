//
//  SignUpViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

// 디비에 저장하기

protocol SignupViewControllerDelegate {
    func isButtonEnable() -> Bool
}

class SignUpViewController: UIViewController {
    
    var ref : DatabaseReference!
    
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
            passwordTextField.delegate = self
        }
    }
    @IBOutlet var nameTextField: UITextField! {
        didSet{
            nameTextField.delegate = self
        }
    }
    @IBAction func cancelSignup(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var registerDone: UIButton! {
        didSet{
            registerDone.isEnabled = false
        }
    }
    @IBAction func registerButton(_ sender: UIButton) {
        guard let id = idTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        guard let profile = profileImageView.image else {
            return
        }
        guard let name = nameTextField.text else {
            return
        }
        var userInfoDict = [String: Any]()
        
        Auth.auth().createUser(withEmail: id, password: password) { (authResult, error) in
            
            // 성공적이라면 디비에 저장해야됨
            guard let user = authResult?.user else {
                // 실패되었을 경우 알림창 뜨게 하기
                let alert = UIAlertController(title:"다시 입력", message: "중복된 아이디입니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
                print("error -> ",error?.localizedDescription)
                return
            }
            userInfoDict["이름"] = name
            userInfoDict["아이디"] = id
            userInfoDict["비밀번호"] = password
            userInfoDict["여행횟수"] = 0
            self.ref = Database.database().reference()
            let newUser = self.ref.child("user").child("\(user)").child("userInfo")
            newUser.setValue(userInfoDict)
            
            print("user ->  ",user)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // 이미지 등록하기
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
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
        // 모든 정보가 넘어갈 때 버튼이 활성화되도록 체크
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
