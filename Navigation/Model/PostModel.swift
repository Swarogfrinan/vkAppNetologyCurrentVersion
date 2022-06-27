//
//  PostModel.swift
//  Navigation
//
//  Created by Артем Свиридов on 15.04.2022.
//

import Foundation

public struct PostModel {
   public var author: String
     public var description: String
     public var image: String
     public var likes: Int
     public var views: Int
//добавление новых постов в ленту скролинга.
     public  static func makeMockModel() ->
     [[PostModel]] {
        var model = [[PostModel]]()
        var section = [PostModel]()
         section.append(PostModel(author: "Жак фреско", description: "Когда мне говорят что я футбольный мячик, я плачу", image:  "post1", likes: 1488, views: 214124))
        section.append(PostModel(author: "Умный парень из твиттера", description: "Жалко что нас купил Илон Маск", image: "post2", likes: 24440, views: 12232))
        section.append(PostModel(author: "Ваш одноклассник", description: "Я люблю маму", image: "post3", likes: 9200, views: 9000))
        section.append(PostModel(author: "Слухи из таверны", description: "Рад что солнышко светит", image: "post4", likes: 49, views: 3331))
        model.append(section)
        return model
    }
}
