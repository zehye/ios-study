//
//  ViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/01/30.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        // ViewController가 picker의 델리게이트 역할을 할 것이다 명시
        // delegate 옵션 눌러서 확인해보면 두가지 delegate의 합성 프로토콜
        // 그렇기 때문에 뷰컨트롤러가 두 개의 프로토콜 채택하도록 명시
        picker.delegate = self
        return picker
    }()
    
    var userModel = UserModel()
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBAction func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchUpSignInButton(_ sender: UIButton) {
        // id, pw 두 필드가 빈문자열이 아니고, nil 이 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        
        // UserInfo Model 이 해당 유저를 가지고 있는지 검사
        let loginSuccess: Bool = userModel.isUser(id: idInput, pw: pwInput)
        
        if loginSuccess {
            // print("로그인 성공")
            // 로그인 성공 시 다음 화면으로
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MusicVC") as! MusicViewController
            
            self.present(vc, animated: true, completion: nil)
            
        } else {
            // print("실패")
            // 실패 시 애니메이션 효과 추가
            UIView.animate(withDuration: 0.2, animations: {
                self.idField.frame.origin.x -= 10
                self.pwField.frame.origin.x -= 10
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.idField.frame.origin.x += 20
                    self.pwField.frame.origin.x += 20
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.idField.frame.origin.x -= 10
                        self.pwField.frame.origin.x -= 10
                    })
                })
            })
            // 애니메이션 구현
            
        }
    }
    
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! SecondViewController

        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setNavigationBarHidden(true, animated: true)

        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.addViewsWithCode()
    }
    
    
    
    func addViewsWithCode() {
        self.addImageView()
        self.addIdTextField()
        self.addPwTextField()
        self.addSignInButton()
        self.addSignUpButton()
    }
    
    
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.backgroundColor = .black
        
        image.isUserInteractionEnabled = true
        let clickImageView = UITapGestureRecognizer(target: self, action: #selector(self.touchUpImage(_:)))
        image.addGestureRecognizer(clickImageView)
        
        let centerX: NSLayoutConstraint
        centerX = image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: image, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.7, constant: 0)
        
        let width: NSLayoutConstraint
        width = image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        let ratio: NSLayoutConstraint
        ratio = image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true
        
        self.imageView = image

    }
    
    
    
    func addIdTextField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(id)
        
//        id.backgroundColor = .yellow
        id.borderStyle = UITextField.BorderStyle.roundedRect
        
        id.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        
        id.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0).isActive = true
        id.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0).isActive = true
        id.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        id.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 50).isActive = true
        
        self.idField = id
    }
    
    
    
    func addPwTextField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pw)
        
//        pw.backgroundColor = .yellow
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        
        pw.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        
        pw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0).isActive = true
        pw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pw.topAnchor.constraint(equalTo: self.idField.bottomAnchor, constant: 16).isActive = true
        
        self.pwField = pw
    }
    
    
    
    func addSignInButton() {
        let signin: UIButton = UIButton(type: UIButton.ButtonType.custom)
        signin.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(signin)
        
        signin.setTitle("SignIn", for: UIControl.State.normal)
        
        signin.addTarget(self, action: #selector(self.touchUpSignInButton(_:)), for: UIControl.Event.touchUpInside)
        
        signin.backgroundColor = .black
        signin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80.0).isActive = true
        signin.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        signin.topAnchor.constraint(equalTo: self.pwField.bottomAnchor, constant: 50).isActive = true
        
        self.signinButton = signin
     
    }
    
    
    
    func addSignUpButton() {
        let signup: UIButton = UIButton(type: UIButton.ButtonType.custom)
        signup.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(signup)
        
        signup.setTitle("SignUp", for: UIControl.State.normal)
        
        signup.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        signup.addTarget(self, action: #selector(self.touchUpSignUpButton(_:)), for: UIControl.Event.touchUpInside)
        
        signup.backgroundColor = .black
        signup.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80.0).isActive = true
        signup.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        signup.topAnchor.constraint(equalTo: self.pwField.bottomAnchor, constant: 50).isActive = true
        
        self.signupButton = signup
        
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idField.isFirstResponder {
            pwField.becomeFirstResponder()
        }
    }
    
    
    // MARK: imagePicker 델리데이트
    // 취소하면 모달 dismiss
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 선택하면
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // ImagePickerControllerDelegate 문서에서 메서드 확인
        // Getting the Editing Information 에서
        // originalImage를 다양한 키를 통해 받아올 수 있는 방법 확인
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

