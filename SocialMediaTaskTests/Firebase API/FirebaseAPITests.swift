//
//  SocialMediaTaskTests.swift
//  SocialMediaTaskTests
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import XCTest
import Moya

@testable import SocialMediaTask
class FirebaseAPITests: XCTestCase
{
    // MARK: Properties
    
    var firebaseNetworkManager: FirebaseNetworkable!

    // MARK: Life Cycle
    
    override func setUp()
    {
        super.setUp()
        
        let stubbingProvider = MoyaProvider<FirebaseAPI>(stubClosure: MoyaProvider.immediatelyStub)
        firebaseNetworkManager = FirebaseNetworkManager(provider: stubbingProvider)
    }

    override func tearDown()
    {
        firebaseNetworkManager = nil
        super.tearDown()
    }

    // MARK: Methods
    
    func testGetPosts()
    {
        // given
        guard let expectedNumberOfPosts = FirebaseTestingManager.shared.getNumberOfPosts()
        else
        {
            XCTFail("Can not get object")
            return
        }
        
        // when
        var fetchedNumberOfPosts = 0
        firebaseNetworkManager.getPosts { result in
            
            if case .success(let response) = result
            {
                fetchedNumberOfPosts = response.count
            }
        }
        
        // then
        let message = "expected: \(expectedNumberOfPosts), fetched: \(fetchedNumberOfPosts)"
        XCTAssert(fetchedNumberOfPosts == expectedNumberOfPosts, message)
    }
}
