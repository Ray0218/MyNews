//
//  SmassVideoPlayCustomerView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/4.
//  Copyright © 2019 Ray. All rights reserved.
//

import BMPlayer

class SmassVideoPlayCustomerView: BMPlayerControlView {

    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none

        playButton.removeFromSuperview()
        currentTimeLabel.removeFromSuperview()
        totalTimeLabel.removeFromSuperview()
        timeSlider.removeFromSuperview()
        fullscreenButton.removeFromSuperview()
    }

}
