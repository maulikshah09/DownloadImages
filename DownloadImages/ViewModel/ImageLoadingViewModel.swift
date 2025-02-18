//
//  ImageLoadingViewModel.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//
import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel : ObservableObject{
    @Published var image : UIImage? = nil
    @Published var isLoading = false
    let urlString: String
    let imageKey : String
    
    var cancellable = Set<AnyCancellable>()
    
    let manager = PhotoModelFileManager.instance
    
    init(url : String,key : String){
        urlString = url
        imageKey = key
        getImage()
    }
     
    func getImage(){
        if let savedImage =  manager.get(key: imageKey){
            image = savedImage
            print("Getting saved image")
        }else{
            downloadImage()
            print("Downloading image Now.")
        }
    }
    
    func downloadImage(){
        print("Downloading image now")
        isLoading = true
      
        guard let url = URL(string: urlString) else{
            isLoading = false
            return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data : $0.data)}
                .receive(on: DispatchQueue.main)
                .sink { [weak self](_) in
                    self?.isLoading = false
                } receiveValue: { [weak self] (returnImage) in
                    self?.image = returnImage
                    self?.manager.add(key: self?.imageKey ?? "", value: returnImage ??  UIImage())
                }
                .store(in: &cancellable)

    }
}
