//
//  AdViewController1.swift
//  AdPractice
//
//  Created by 藤井凜 on 2021/08/31.
//

import UIKit
import NendAd

class AdViewController1: UIViewController, NADInterstitialVideoDelegate {
  
  
  //動画広告
  let adVideo = NADInterstitialVideo(spotID: 000000, apiKey: "apikey")
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    adVideo.delegate = self
    adVideo.loadAd()
  }
  
  
  //動画広告を表示
  @IBAction func tapButton(_ sender: Any) {
    
    if adVideo.isReady {
      
      adVideo.showAd(from: self)
    }
  }
  
  
  //広告を受信した時
  func nadInterstitialVideoAdDidReceiveAd(_ nadInterstitialVideoAd: NADInterstitialVideo!) {
    
    print("受信ができました")
  }
  
  //エラー
  func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!) {
    
    print(error.debugDescription)
  }
  
  //表示がされない場合
  func nadInterstitialVideoAdDidFailed(toPlay nadInterstitialVideoAd: NADInterstitialVideo!) {
    
    print("表示がされませんでした")
  }
  
}
