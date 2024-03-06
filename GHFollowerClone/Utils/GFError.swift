//
//  ErrorMessage.swift
//  GHFollowerClone
//
//  Created by DucLong on 04/03/2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername            = "Error name, try again!"
    case noInternetConnection       = "Cant connect to server, check internet again"
    case invalidResponse            = "Invalid response from Server"
    case invalidData                = "Data received error"
    case emptyList                  = "No Data Founded!"
}
