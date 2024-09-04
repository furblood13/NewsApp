//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Furkan buğra karcı on 18.08.2024.
//

import Foundation
class NewsViewModel:ObservableObject{
    @Published var news :[News] = []
    @Published var isLoading=false
    @Published var paging=0
    @Published var selectedURL: IdentifiableURL?
    private let apikey="0dhoNryXafOIbjFs5jk8L8:5Xchk0xydzVFY48DKWyd6w"
    
    
    
    func fetchDutyNews(){
        isLoading=true
        let headers = [
            "content-type": "application/json",
            "authorization": "apikey \(apikey)"
        ]
        
        guard let url = URL(string:"https://api.collectapi.com/news/getNews?country=tr&paging=\(paging)&tag= ") else{
            print("geçersiz url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session=URLSession.shared
        session.dataTask(with: request){
            [weak self] data,response,error in DispatchQueue.main.async {
                self?.isLoading = false
            }
            if let jsonData = data, let jsonString = String(data:jsonData,encoding: .utf8){
                print("Gelen JSON: \(jsonString)")
            }
            if let error=error{
                print("Hata\(error.localizedDescription)")
                return
            }
            guard let data=data else{
                print("veri alınamadı")
                return
            }
            do{
                let decodedResponse = try JSONDecoder().decode(NewsResponce.self, from: data)
                if decodedResponse.success, let news = decodedResponse.result{
                    DispatchQueue.main.async {
                        self?.news=news
                    }
                }
                else{
                    print("APİ isteği başarısız veya sonuçlar yok")
                }
            }catch let DecodingError.dataCorrupted(context) {
                print("Veri bozulmuş: \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Anahtar bulunamadı: \(key) context: \(context)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Tip uyuşmazlığı: \(type) context: \(context)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Değer bulunamadı: \(value) context: \(context)")
            } catch {
                print("Genel hata: \(error.localizedDescription)")
            }
        }.resume()
        
        
    }
    func selectNewsItem(_ newsItem: News) {
            if let url = URL(string: newsItem.url) {
                selectedURL = IdentifiableURL(url: url)
            }
        }

}

