//
//  ScoreHelper.swift
//  something
//
//  Created by Yu Hong on 2021/1/10.
//

import UIKit

public class ScoreHelper: NSObject {
    
    private let kHeightScoreKey = "highest_score"
    private let kLastestScoreKey = "lastest_score"
    private let kALLScoreKey = "all_score"
    
    private var array: [Int] = [Int]()
    
    public override init() {
        
    }

    static let shared: ScoreHelper = ScoreHelper()
    
    func getHighestScore() -> Int {
        return UserDefaults.standard.integer(forKey: kHeightScoreKey)
    }
    
    func setHighestScore(_ score: Int) {
        if score > getHighestScore() {
            UserDefaults.standard.set(score, forKey: kHeightScoreKey)
            UserDefaults.standard.synchronize()
        }
    }
    func getLastestScore() -> Int{
        return UserDefaults.standard.integer(forKey: kLastestScoreKey)
    }
    
    func setLastestScore(_ score: Int){
        UserDefaults.standard.set(score, forKey: kLastestScoreKey)
        UserDefaults.standard.synchronize()
    }
    
    func setAllScore(_ score: Int)
    {
        array = readAllSocre()
        array.append(score)
        array.sort()
        array.reverse()
        UserDefaults.standard.set(array, forKey: kALLScoreKey)
    }
    
    func readAllSocre() -> [Int]
    {
        array.reverse()
        return UserDefaults.standard.array(forKey: kALLScoreKey) as? [Int] ?? [Int]()
    }
    
    
    
}
