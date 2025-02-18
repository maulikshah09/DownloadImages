//
//  PhotoModelFileManager.swift
//  DownloadImages
//
//  Created by Maulik Shah on 2/18/25.
//

import Foundation
import SwiftUI

class PhotoModelFileManager{
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_Photos"
    
    private init(){
        createFolderIfneeded()
    }
    
    private func createFolderIfneeded(){
        guard let url = getFolder() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
                print("Created Folder")
            }catch let error {
                print("Error Creating folder",error)
            }
        }
    }
    
    private func getFolder() -> URL?{
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key : String) -> URL?{
        guard let folder = getFolder() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String,value : UIImage){
        guard let data = value.pngData(),let url = getImagePath(key: key)else {
            return
        }
        
        do {
            try data.write(to: url)
        }catch let error {
            print("Error saving to file manager")
        }
    }
    
    func get(key: String) -> UIImage?{
        guard let url =  getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path)else{
            return nil
        }
            
        return UIImage(contentsOfFile: url.path)
    }
}
