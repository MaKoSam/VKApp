//
//  PhotoCache.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 28/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit


class PhotoCacheService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hasheName = String(describing: url.hashValue)
        return cachesDirectory.appendingPathComponent(PhotoCacheService.pathName + "/" + hasheName).path
    }
    
    private func saveImageToChache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url) else { return }
        let data = image.pngData()
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromChache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }

        
        images[url] = image
        return image
    }

    
    private var images = [String: UIImage]()
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        let imgURL = URL(string: url)
        DispatchQueue.global(qos: .default).async {
            if let imageURL = imgURL {
                do {
                    let data = try Data(contentsOf: imageURL)
                    let img = UIImage(data: data)
                    if let image = img {
                        self.images[url] = image
                        self.saveImageToChache(url: url, image: image)
                    }
                    DispatchQueue.main.async {
                        self.container.reloadRow(atIndexpath: indexPath)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func UPDPhotoCacheExists(byUrl url: String) -> Bool{
        if let filePath = getFilePath(url: url){
            if FileManager.default.fileExists(atPath: filePath){
                let info = try? FileManager.default.attributesOfItem(atPath: filePath)
                if let modificationDate = info?[FileAttributeKey.modificationDate] as? Date {
                    let lifeTime = Date().timeIntervalSince(modificationDate)
                    if lifeTime >= cacheLifeTime {
                        return false
                    }
                }
                return true
            }
        }
        return false
    }
    
    func UpdatePhotoCaches(byUrl url: String){
        if !UPDPhotoCacheExists(byUrl: url) {
            let imgURL = URL(string: url)
            DispatchQueue.global(qos: .default).async {
                if let imageURL = imgURL {
                    do {
                        let data = try Data(contentsOf: imageURL)
                        let img = UIImage(data: data)
                        if let image = img {
//                            self.images[url] = image
                            self.saveImageToChache(url: url, image: image)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromChache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
        
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoCacheService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
