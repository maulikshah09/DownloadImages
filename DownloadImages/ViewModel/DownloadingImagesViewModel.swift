
//
//  DownloadingImagesViewModel.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//


import Foundation
import Combine

class DownloadingImagesViewModel : ObservableObject{
    @Published var dataArray : [PhotoModel] = []
    var cancellable = Set<AnyCancellable>()
    
    
    let dataService = PhotoModelDataServies.instance
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber(){
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModel in
                self?.dataArray = returnedPhotoModel
        }
            .store(in: &cancellable)

    }
}
