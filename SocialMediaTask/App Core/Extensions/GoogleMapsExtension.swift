//
//  GoogleMapsExtension.swift
//  Rakeb user
//
//  Created by Mohamed Shemy on Fri,17 Jul,2020.
//  Copyright © 2020 Alamat. All rights reserved.
//

import GoogleMaps

// MARK: - GMSMutablePath
extension GMSMutablePath
{
    func append(path : GMSPath?)
    {
        if let path = path
        {
            for i in 0..<path.count()
            {
                self.add(path.coordinate(at: i))
            }
        }
    }
}

// MARK: - CLLocationCoordinate2D
extension CLLocationCoordinate2D
{
    /// Distance Between Two Geo-Points
    func distance(to: CLLocationCoordinate2D) -> Double
    {
        let lat1 = self.latitude
        let lon1 = self.longitude
        
        let lat2 = to.latitude
        let lon2 = to.longitude
        
        let p = 0.017453292519943295
        let a = 0.5 - cos((lat2 - lat1) * p)/2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p))/2
        
        return 12742 * asin(sqrt(a)) // 2 * R; R = 6371 km approximate Earth radius
    }
}

// MARK: - [CLLocationCoordinate2D]
extension Array where Element == CLLocationCoordinate2D
{
    mutating func sort(by location: CLLocationCoordinate2D)
    {
        return sort(by: { $0.distance(to: location) < $1.distance(to: location) })
    }
    
    func sorted(by location: CLLocationCoordinate2D) -> [CLLocationCoordinate2D]
    {
        return sorted(by: { $0.distance(to: location) < $1.distance(to: location) })
    }
}
