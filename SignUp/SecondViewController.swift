//
//  SecondViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        
        // id, pw, pwcheck 세 필드 모두 빈문자열 아니고, nil 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        guard let pwCheck = pwCheckField.text, !pwCheck.isEmpty else { return }
        
        if pwInput == pwCheck {
            print("다음 페이지로")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonVC") as! ThirdViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else {
            print("pw = check, 다시 입력")
        }
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonVC") as! ThirdViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addViewsWithCode()
    }
    

    func addViewsWithCode() {
        self.addImageView()
        self.addIdInputField()
        self.addPwInputField()
        self.addPwCheckField()
        self.addTextView()
        self.addCancelButton()
        self.addNextButton()
    }
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.backgroundColor = .black
        
        image.isUserInteractionEnabled = true
        let clickImageView = UITapGestureRecognizer(target: self, action: #selector(self.touchUpImage(_:)))
        image.addGestureRecognizer(clickImageView)
        
        image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    func addIdInputField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(id)
        
        id.borderStyle = UITextField.BorderStyle.roundedRect
        
        id.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        
        id.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        id.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        
        self.idField = id
    }
    
    func addPwInputField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        
        pw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        pw.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 8).isActive = true
        
        self.pwField = pw
    }
    
    func addPwCheckField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        
        pw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        pw.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 8).isActive = true
        
        self.pwCheckField = pw
    }
    
    func addTextView() {
        let text: UITextView = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(text)
        
        text.isEditable = true
        text.backgroundColor = .black
        
//        text.layer.borderColor = UIColor.
        
        text.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        
        text.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        
        text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        
        text.heightAnchor.constraint(equalTo: text.widthAnchor, multiplier: 1).isActive = true
        
        
        self.textView = text
    }
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.backgroundColor = .black
        
        cancel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        cancel.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.cancelButton = cancel
        
    }
    
    func addNextButton() {
        let next: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        next.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(next)
        
//        if imageView.image != nil {
//            <#code#>
//        }
        
        next.setTitle("Next", for: UIControl.State.normal)
        
        
        
        next.addTarget(self, action: #selector(self.touchUpNextButton(_:)), for: UIControl.Event.touchUpInside)
        
        next.backgroundColor = .black
        
        next.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80).isActive = true
        next.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        next.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.nextButton = next
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
