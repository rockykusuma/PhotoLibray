//
//  Environment.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

/// Enum for environment related to constants
class Environment {
    
    /// Get the base URL as per the build configuration
    static var imgurURL: String {
        #if DEV
        return "https://api.imgur.com/3"
        #elseif QA
        return "https://api.imgur.com/3"
        #elseif STAGING
        return "https://api.imgur.com/3"
        #else
        return "https://api.imgur.com/3"
        #endif
    }
}
