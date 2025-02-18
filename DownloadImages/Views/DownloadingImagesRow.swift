//
//  DownloadingImagesRow.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//

import SwiftUI

struct DownloadingImagesRow: View {
    let model : PhotoModel
    var body: some View {
        HStack{
            DownloadingImageView(url: model.thumbnail ?? "", key: "\(model.id ?? 0)")
                .frame(width: 75,height: 75)
            
            VStack(alignment: .leading) {
                Text(model.title ?? "")
                    .font(.headline)
                Text(model.description ?? "")
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadingImagesRow(model: PhotoModel(id: 1, albumId: 1, title: "title", url: "https://via.placeholder.com/600/24f355", thumbnail: "https://via.placeholder.com/150/24f355"))
        .padding()
}


