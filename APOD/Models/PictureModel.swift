//
//  PictureModel.swift
//  APOD
//
//  Created by William Johanssen Hutama on 01/03/22.
//

import Foundation

struct Picture: Decodable{
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String
    let service_version: String
    let title: String
    let url: String?
    let thumbnail_url: String?
}

