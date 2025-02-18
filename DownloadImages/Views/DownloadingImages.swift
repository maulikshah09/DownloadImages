//
//  ContentView.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//

import SwiftUI

//background threads
//weak self
//combine
// publisher and subscriber
// filemanager
// nscache


struct DownloadingImages: View {
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(vm.dataArray){ model in
                    DownloadingImagesRow(model: model)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Downloading Images!")
        }
    }
}

#Preview {
    DownloadingImages()
}
