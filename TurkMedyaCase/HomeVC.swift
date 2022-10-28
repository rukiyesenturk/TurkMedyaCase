//
//  ViewController.swift
//  TurkMedyaCase
//
//  Created by Rukiye Şentürk on 27.10.2022.
//

import UIKit
import Kingfisher
import StreamingKit

class HomeVC: UIViewController, NewsManagerDelegate {
  
    @IBOutlet weak var greyView: UIView!
    
    @IBOutlet weak var newsCollactionView: UICollectionView!
    let url = "https://turkmedya-live.ercdn.net/tv24/tv24.m3u8"
    var itemList: [ItemList] = []
    
    private let videoPlayer = StreamingVideoPlayer()
    
    func getNewsData(_ newsManager: NewsManager, _ newsData: [NewsData]) {
        DispatchQueue.main.async {
            self.itemList = newsData.first!.data.first!.itemList
            self.newsCollactionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()

        var newsManager = NewsManager()
        newsManager.delegate = self
        newsManager.performRequest()
        
        newsCollactionView.delegate = self
        newsCollactionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        newsCollactionView.collectionViewLayout = layout
        
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let url = URL(string: url) else {
            print("Error")
            return }
        videoPlayer.play(url: url)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    private func setupVideoPlayer() {
        videoPlayer.add(to: greyView)
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(itemList.count)
        return itemList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        cell.imgNews.kf.setImage(with: URL(string: itemList[indexPath.row].imageURL))
        cell.lblNewsTitle.text = itemList[indexPath.row].title
        cell.lblNewsPublishDate.text = itemList[indexPath.row].publishDate
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        videoPlayer.pause()
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widht = UIScreen.main.bounds.width
        let itemWidht = (widht - gridLayout.sectionInset.right - gridLayout.sectionInset.left)
        return CGSize(width: itemWidht, height: 120)
     
    }
}
