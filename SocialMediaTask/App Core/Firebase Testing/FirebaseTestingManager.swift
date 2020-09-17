//
//  FirebaseTestingManager.swift
//  SocialMediaTaskTests
//
//  Created by Essam Mohamed Fahmi on 9/17/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

public class FirebaseTestingManager
{
    // MARK: Properties
    
    static let shared = FirebaseTestingManager()
    private let JSONFileName = "FirebaseTestJSONData"
    
    // MARK: Initialization
    
    private init(){}
    
    // MARK: Methods
    
    func getJSONData() -> Data
    {
        let path = Bundle.main.path(forResource: JSONFileName, ofType: "json")
        if let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        {
            return jsonData as Data
        }
        
        return Data()
    }
    
    func getNumberOfPosts() -> Int?
    {
        if let response = try? JSONDecoder().decode([String: Post].self, from: getJSONData())
        {
            return response.count
        }
        
        return nil
    }
}
