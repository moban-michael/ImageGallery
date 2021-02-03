//
//  Response.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import Foundation

enum Response<ResultType> {
  case success(ResultType)
  case error(Error)
}
