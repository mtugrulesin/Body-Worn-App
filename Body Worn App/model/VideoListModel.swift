//
//  VideoListModel.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import Foundation



struct VideoListModel: Decodable {
    var event:String
    var videoList: [String] = []
}
