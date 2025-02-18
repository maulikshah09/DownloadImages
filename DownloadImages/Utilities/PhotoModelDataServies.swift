//
//  PhotoModelDataServies.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//

import Foundation
import Combine

class PhotoModelDataServies {
    static let instance = PhotoModelDataServies()
    @Published var photoModels: [PhotoModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    private init(){
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string:"https://dummyjson.com/products") else{
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(HandleOutput)
            .decode(type: ProductModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error download data \(error)")
                }
                
            } receiveValue: { photoInfo in
                self.photoModels = photoInfo.products ?? [PhotoModel]()
            }
            .store(in: &cancellable)

    }
    
    private func HandleOutput(output : URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
