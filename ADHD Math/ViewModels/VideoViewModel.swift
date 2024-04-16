

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var videos = [VideoModel]() {
        didSet {
            saveVideos()
        }
    }
    
    var fileName = "videos"
    var videoKey = "videos"
    
    init() {
        fetchFromUserDefaults()
    }
    
    func fetchFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: videoKey) {
            do {
                let decodedData = try JSONDecoder().decode([VideoModel].self, from: savedData)
                self.videos = decodedData
            } catch {
                print("Failed to fetch learn exercises from UserDefaults")
            }
        } else {
            fetchFromJson()
        }
    }
    
    func fetchFromJson() {
        guard let url = Bundle.main.url(forResource: self.fileName, withExtension: "json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            do {
                if let jsonData = data {
                    let result = try JSONDecoder().decode([VideoModel].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.videos = result
                    }
                } else {
                    print("No data")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func saveVideos() {
        do {
            let encodedData = try JSONEncoder().encode(videos)
            UserDefaults.standard.set(encodedData, forKey: videoKey)
        } catch {
            print("Failed to save lessons to UserDefaults")
        }
    }
    
    func getVideoFromFileTitle(fileTitle: String) -> VideoModel {
        return videos.filter{ $0.fileTitle == fileTitle }.first ?? VideoModel.noVideo
    }
}
