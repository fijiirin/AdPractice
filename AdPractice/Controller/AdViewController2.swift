//
//  AdViewController2.swift
//  AdPractice
//
//  Created by 藤井凜 on 2021/08/31.
//

import UIKit
import NendAd

class AdViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource, NADViewDelegate {
  
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var nadView: NADView!
  
  var textArray = ["ニュース1", "ニュース2", "ニュース3", "ニュース4", "ニュース5"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    //バナー広告
    nadView.setNendID(0000000, apiKey: "apikey")
    nadView.delegate = self
    nadView.load()
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return textArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = textArray[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    let result = NADInterstitial.sharedInstance().showAd(from: self)
    
    //エラーの確認
    switch(result){
    case .AD_SHOW_SUCCESS:
      print("広告の表示に成功")
      break
    case .AD_SHOW_ALREADY:
      print("既に広告が表示されています")
      break
    case .AD_FREQUENCY_NOT_REACHABLE:
      print("広告のフリークエンシーカウントに達していません")
      break
    case .AD_LOAD_INCOMPLETE:
      print("抽選リクエストが実行されていない、もしくは実行中")
      break
    case .AD_REQUEST_INCOMPLETE:
      print("抽選リクエストに失敗")
      break
    case .AD_DOWNLOAD_INCOMPLETE:
      print("広告のダウンロードが完了していません")
      break
    case .AD_CANNOT_DISPLAY:
      print("指定されたViewControllerに広告が表示できませんでした")
      break
    @unknown default:
      break
    }
  }
  
  
  //ロード完了時
  func nadViewDidFinishLoad(_ adView: NADView!) {
    print("delegate nadViewDidFinishLoad:")
  }
  
  //受信成功時
  func nadViewDidReceiveAd(_ adView: NADView!) {
    print("delegate nadViewDidReceiveAd")
  }
  
  //エラー
  func nadViewDidFail(toReceiveAd adView: NADView!) {
    // エラーごとに処理を分岐
    let error: NSError = adView.error as NSError
    
    switch (error.code) {
    case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.rawValue:
      // 広告サイズがディスプレイサイズよりも大きい
      break
    case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.rawValue:
      // 不明な広告ビュータイプ
      break
    case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.rawValue:
      // 広告取得失敗
      break
    case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.rawValue:
      // 広告画像の取得失敗
      break
    case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.rawValue:
      // リクエストしたサイズと取得したサイズが異なる
      break
    default:
      break
    }
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
