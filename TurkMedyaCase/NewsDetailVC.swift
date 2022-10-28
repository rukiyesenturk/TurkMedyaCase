//
//  NewsDetailVC.swift
//  TurkMedyaCase
//
//  Created by Rukiye Şentürk on 28.10.2022.
//

import UIKit

class NewsDetailVC: UIViewController, NewsDetailManagerDelegate {

    var itemList: [Video] = []
    var fullPath = "https://www.aksam.com.tr/dunya/abd-baskani--trump-japonyanin-105-adet-f35-savas-ucagi-almayi-kabul-ettigini-duyurdu/haber-975413"
  
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newsManager = NewsDetailManager()
        newsManager.delegate = self
        newsManager.performRequest()
        UIApplication.shared.statusBarStyle = .darkContent
    }
    func getNewsData(_ newsManager: NewsDetailManager, _ newsData: [NewsDetailData]) {
        DispatchQueue.main.async {
           // self.lbl.text = newsData.first!.data.newsDetail.bodyText
            self.fullPath = newsData.first!.data.newsDetail.fullPath
            
            let url:NSURL = NSURL(string: self.fullPath)!
            let urlRequest :NSURLRequest = NSURLRequest(url: url as URL)
            
            self.webView.loadRequest(urlRequest as URLRequest)
        }
    }
   
}
