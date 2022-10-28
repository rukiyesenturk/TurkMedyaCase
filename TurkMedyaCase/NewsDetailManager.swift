//
//  NewsDetailManager.swift
//  TurkMedyaCase
//
//  Created by Rukiye Şentürk on 28.10.2022.
//

import Foundation

protocol NewsDetailManagerDelegate {
    func getNewsData(_ newsManager: NewsDetailManager, _ newsData: [NewsDetailData])
}
struct NewsDetailManager {
    let newsUrl = "https://turkmedya.com.tr/detay.json"
    
    var delegate: NewsDetailManagerDelegate?

    func performRequest() {
        if let url = URL(string: newsUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, URLResponse, error) in
                if error != nil {
                    print("Error")
                    return
                }
                if let newsData = data {
                    print(newsData)
                    if let news :[NewsDetailData] = parseJSON(newsData) {
                        self.delegate?.getNewsData(self, news)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON<T: Decodable>(_ newsData: Data) -> [T]? {
        let decoder = JSONDecoder()
        var newsArray = [T]()
        do {
            let decodeData = try decoder.decode(T.self, from: newsData)
            newsArray.append(decodeData)
            return newsArray
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
