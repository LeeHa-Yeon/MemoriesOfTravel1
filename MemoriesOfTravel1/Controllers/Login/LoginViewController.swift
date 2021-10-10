//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/09/27.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomMargin = self.bottomContainerMargin.constant
        addNotification()
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
        login{ response in
            guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeSB") as? ViewController else {
                return
            }
            self.loadingUserFB(userInfoDict: response)
            self.present(HomeVC,animated: true, completion: nil)
        }
    }
    
    @IBAction func moveToSignUp(_ sender: UIButton){
        if let SingUpVC = self.storyboard?.instantiateViewController(identifier: "SingUpSB") {
            self.present(SingUpVC,animated: true, completion: nil)
        }
    }
    
    func login(completion: @escaping (([String:Any])->(Void))){
        guard let id = idTextField.text else {
            return
        }
        guard let password = pwdTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: id, password: password) { (user,error) in
            // 로그인 성공 : "Login Success"
            if user != nil {
                self.ref.child("user").observeSingleEvent(of: .value, with: { (snapshot) in
                    let dic = snapshot.value as! [String: [String:Any]]
                    var findUserInfo : [String:Any] = [:]
                    for (key,index) in dic{
                        let usersInfo = index["userInfo"] as! [String:Any]
                        // 로그인 유저를 데이터베이스에서 찾아서 findUserInfo 변수에 저장
                        if (usersInfo["아이디"] as! String == "\(id)"){
                            findUserInfo = usersInfo
                            findUserInfo["primaryKey"] = key
                        }
                    }
                    completion(findUserInfo)
                })

            }else {
                // 실패되었을 경우 알림창 뜨게 하기
                let alert = UIAlertController(title:"로그인 실패", message: "아이디와 비밀번호를 확인해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
                print("error -> ",error?.localizedDescription ?? "")
            }
        } // Auth end
    } // login end
    
    func loadingUserFB(userInfoDict: [String: Any]){
        myInformation.setPrimaryKey(primaryKey: userInfoDict["primaryKey"] as! String)
        myInformation.setUserId(id: userInfoDict["아이디"] as! String)
        myInformation.setUserName(name: userInfoDict["이름"] as! String)
        myInformation.setUserPwd(password: userInfoDict["비밀번호"] as! String)
        myInformation.setUserTripCnt(tripCnt: userInfoDict["여행횟수"] as! Int)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
