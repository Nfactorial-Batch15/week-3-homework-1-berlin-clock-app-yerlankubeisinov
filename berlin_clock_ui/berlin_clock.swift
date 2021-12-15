//
//  berlin_clock.swift
//  berlin_clock_ui
//
//  Created by Yerlan Kubeisinov on 14.12.2021.
//

import Foundation

class BerlinClock {
    
    func berlinClock(_ hours: Int ,_ minutes: Int,_ seconds: Int) -> String {
        return getSeconds(seconds) + " " + getHours(hours) + " " + getMinutes(minutes)
    }
    
    func rawBerlinClock(_ hours: Int ,_ minutes: Int,_ seconds: Int) -> String {
        return getSeconds(seconds) + getHours(hours) + getMinutes(minutes)
    }
    
    func getSeconds(_ seconds: Int) -> String {
        return seconds % 2 == 0 ? "Y" : "O"
    }

    func getHours(_ hours: Int) -> String {
        let numberTopHourLamps = hours / 5
        let numberBottomHourLamps = hours % 5
        
        var sb: [String] = []
        sb.append(getLampRow(4, numberTopHourLamps, "R"))
        sb.append(getLampRow(4, numberBottomHourLamps, "R"))
        
        return sb.compactMap { $0 as String }.joined()
    }
    
    func getMinutes(_ minutes: Int) -> String {
        let numberTopMinutesLamps = minutes / 5
        let numberBottomMinutesLamps = minutes % 5
        
        var sb: [String] = []
        
        for n in 1...11 {
            sb.append(n <= numberTopMinutesLamps ? getMinuteLampColour(n) : "O")
        }

        sb.append(getLampRow(4, numberBottomMinutesLamps, "Y"))
        
        return sb.compactMap { $0 as String }.joined()
    }
    
    func getLampRow(_ totalNumberLamps: Int, _ numberLampsOn: Int, _ lampSymbol: String) -> String {
        var sb: [String] = []
        
        for n in 1...totalNumberLamps {
            sb.append(n <= numberLampsOn ? lampSymbol : "O")
        }

        return sb.compactMap { $0 as String }.joined()
    }
    
    func getMinuteLampColour(_ index: Int) -> String {
        return index % 3 == 0 ? "R" : "Y"
    }
}
