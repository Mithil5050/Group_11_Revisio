//
//  ProgressViewModel.swift
//  Group_11_Revisio
//
//  Created by Ashika Yadav on 26/11/25.
//

import Foundation

protocol ProgressViewModelDelegate: AnyObject {
    func didUpdateStudyData()
    func didUpdateAchievements()
}

class ProgressViewModel {
    weak var delegate: ProgressViewModelDelegate?
    
    // MARK: - Data/State
    var selectedTimeframe: String = "Day"
    var dailyStudyHours: [Double] = [3.0, 5.0, 7.0, 9.5, 8.0, 4.0, 2.0]
    var weeklyStudyHours: [Double] = [20.0, 18.0, 22.0, 15.0]
    var currentChartData: [Double] {
        return selectedTimeframe == "Day" ? dailyStudyHours : weeklyStudyHours
    }
    
    var streakDays: Int = 7
    var bestSubject: String = "Swift"
    var awardProgressText: String = "20 of 30 days"

    // MARK: - Logic
    func fetchStudyData(for period: String) {
        self.selectedTimeframe = period
        
        // Real implementation would fetch data asynchronously
        delegate?.didUpdateStudyData()
    }
    
    func fetchAchievements() {
        // Real implementation would fetch achievement details
        delegate?.didUpdateAchievements()
    }
}
