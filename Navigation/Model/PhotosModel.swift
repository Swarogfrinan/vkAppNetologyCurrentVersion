//
//  PhotosModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 01.05.2022.
//

import Foundation

struct PhotosModel {
    var image: String
    
    static func makeMockModel() -> [PhotosModel] {
        var model = [PhotosModel]()
        for element in 1...20 {
            model.append(PhotosModel(image: "photo\(element)"))
        }
        return model
    }
}
