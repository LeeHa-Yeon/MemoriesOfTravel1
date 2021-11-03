//
//  LodingViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    
    //Lottie AnimationView 생성
    // 78118-loading-balance
    let animationView = AnimationView(name:"5783-loding")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x:0, y:0, width:200, height:200)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
//        animationView.play()
//        animationView.loopMode = .loop
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //애니메이션 시간 후에 작동하게끔.
        self.animationView.play()
        self.animationView.loopMode = .loop
        let time = DispatchTime.now() + .seconds(6)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            let board = UIStoryboard(name: "Main", bundle: nil)
            let vc = board.instantiateViewController(withIdentifier: "LoginSB")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)

        }
    }
}
