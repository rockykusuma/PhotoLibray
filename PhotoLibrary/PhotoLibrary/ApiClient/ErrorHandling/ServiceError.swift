//
//  ServiceError.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

/// Error information returned at Decoding
struct ServiceError: Decodable {
    var errorCode: String?
    var errorSummary: String?
}
