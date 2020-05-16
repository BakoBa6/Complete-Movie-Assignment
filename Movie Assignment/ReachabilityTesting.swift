//
//  Reachability.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/15/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//
//
import Foundation
import Reachability
class ReachabilityTesting{
    static let sharedReachability = ReachabilityTesting()
    let reachability = try! Reachability()
    
    func AddObserverForReachability<T:UIViewController>(forViewController viewController:T){
        NotificationCenter.default.addObserver(viewController, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        }catch{
            print(error.localizedDescription)
        }
    
    }
    @objc func reachabilityChanged(note:Notification){
        let reachability = note.object as! Reachability
        switch reachability.connection{
        case .none:
        print("none")
        case .unavailable:
            print("unavailable")
        case .wifi:
            print("wifi")
        case .cellular:
            print("cellular")
        }
    }
}
