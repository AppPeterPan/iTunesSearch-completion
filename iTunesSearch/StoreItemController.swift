
import Foundation
import UIKit

class StoreItemController {
    
    static let shared = StoreItemController()
    
    func fetchItems(term: String, media: String, lang: String, limit: Int, completion: @escaping ([StoreItem]?) -> Void) {
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=\(media)&lang=\(lang)&limit=\(limit)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    completion(searchResponse.results)
                } catch {
                    print(error)
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
