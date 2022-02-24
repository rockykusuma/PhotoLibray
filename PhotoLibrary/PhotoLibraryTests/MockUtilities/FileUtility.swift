//
//  FileUtility.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation

public struct FileUtility {
    
    public static func objectFromJsonFile<T: Decodable>(_ decodedType: T.Type, fileNameBase: String, bundle: Bundle) -> T? {
        guard let fileData = self.dataFromFile(fileNameBase, ofType: "json", bundle: bundle) else {
            return nil
        }
        
        do {
            return try self.mapJSONToObjectDecoder(decodedType, fileData)
        } catch(let error) {
            print("Error parsing \(decodedType.self) \(error)")
            return nil
        }
    }
    
    /// - Parameters:
    ///   - name: resource name without extension. e.g. for filename my_data.json supply "my_data"
    ///   - type: file extension, e.g. "json"
    ///   - bundle: bundle to search for the file e.g. Bundle.main or a test bundle
    ///   returns Data from file, else nil
    public static func dataFromFile(_ name: String, ofType type: String, bundle: Bundle) -> Data? {
        guard let path = bundle.path(forResource: name, ofType: type) else {
            print("path is not found")
            return nil
        }
        print("path = \(path)")
        if let fileData = NSData(contentsOfFile: path) {
            return fileData as Data
        }
        print("failed to convert to data")
        return nil
    }
    
    public static func mapJSONToObjectDecoder<T: Decodable>(_ expectedType: T.Type, _ jsonData: Data) throws -> T {
        let dataModel = try JSONDecoder().decode(T.self, from: jsonData)
        return dataModel
    }
}
