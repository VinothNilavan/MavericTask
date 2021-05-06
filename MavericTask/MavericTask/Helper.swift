//
//  Helper.swift
//  MavericTask
//
//  Created by Vinoth on 06/05/21.
//

import Foundation

protocol SlidShowProtocol {
    var imageUrl:String? { get }
    var id:Int? { get }
}
struct SlideShowModel : SlidShowProtocol {
    var imageUrl:String?
    var content:[TvModel]?
    var id:Int?
}
struct TvModel : SlidShowProtocol {
    var imageUrl:String?
    var title:String?
    var id:Int?
}
