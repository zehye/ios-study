//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Sumin Lee on 2020/01/22.
//  Copyright © 2020 Sumin Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    // 인스턴스 이름을 변경하면 런타임 에러
    // 바꿔줄 것이면 View Controller에서 잘못 된 연결을 수정 하거나 Refector -> Rename을 선택해 변경
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // IBAction : 클릭, 터치 등 동적인 상태를 처리하는 메소드와 연결
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        print("clicked")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print("clicked")
    }
    
}

