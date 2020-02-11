//
//  MusicViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/11.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, AVAudioPlayerDelegate {

    
    // MARK:- Properties
    var player: AVAudioPlayer!
    var timer: Timer!
    
    // IBOutlets
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.addViewsWithCode()
        self.initializePlayer()
        
    }
    
    // MARK: - Methods
    // MARK: Custom Method
    
    @IBAction func touchCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 뮤직플레이어를 초기화하는 메서드
    func initializePlayer() {
        
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원 파일 에셋을 가져올 수 없습니다")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            // 이 뷰컨트롤러의 인스턴스가 player(AVAudioPlayer클래스타입)의 delegate로 역할을 수행하겠다고 할당한 것
            // 뷰컨트롤러가 player의 delegate역할을 수행하겠다.
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
    
    // 레이블을 매초마다 업데이트 해주는 메서드
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        
        self.timeLabel.text = timeText
    }
    
    // 타이머 만들고 수행
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    // 타이머 해제
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    func addViewsWithCode() {
        self.addPlayPauseButton()
        self.addTimeLabel()
        self.addProgressSlider()
        self.addCancelButton()
    }
    
    func addPlayPauseButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)
        
        // 타겟은 뷰컨트롤러, 액션은 touchUpPlayPauseButton
        // 이벤트가 발생하면 타겟을 타겟의 액션으로 호출하게 된다
        // addTarget 메서드(타겟self, action:어떤액션?, for:어떤이벤트)
        // 이렇게 어떤 이벤트가 발생했을 때, 타겟을 정해놓고 액션 실행하는 패턴이 타겟 액션 디자인 패턴이다
        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
        
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0)
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
        
        let ratio: NSLayoutConstraint
        ratio = button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true
        
        self.playPauseButton = button
    }
    
    func addTimeLabel() {
        let timeLabel: UILabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(timeLabel)
        
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        let centerX: NSLayoutConstraint
        centerX = timeLabel.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = timeLabel.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 16)
        
        centerX.isActive = true
        top.isActive = true
        
        self.timeLabel = timeLabel
        self.updateTimeLabelText(time: 0)
    }
    
    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        
        slider.minimumTrackTintColor = UIColor.red
        
        slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: self.timeLabel.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 16)
        
        let leading: NSLayoutConstraint
        leading = slider.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16)
        
        let trailing: NSLayoutConstraint
        trailing = slider.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
        
        centerX.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.progressSlider = slider
    }
    
    func addCancelButton() {
        let cancel: UIButton = UIButton()
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
//        cancel.buttonType = UIButton.ButtonType.custom
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        cancel.addTarget(self, action: #selector(self.touchCancel(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.backgroundColor = .black
        
        cancel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cancel.topAnchor.constraint(equalTo: self.progressSlider.bottomAnchor, constant: 32).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.cancelButton = cancel
        
        
    }
    
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        
        //        print("button tapped")
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
            
        }
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        //        print("slider value changed")
        
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    // MARK: AVAudioPlayerDelegate
    // 어떤 상황이 발생할 때마다 미리 약속해두었던 메서드들을 수행
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류발생")
            return
        }
        
        let message: String
        message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // AudioPlayer의 플레이가 끝났을 때 호출할 메서드
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }

}
