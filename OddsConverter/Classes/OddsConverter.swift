//
//  OddsConverter.swift
//  Pods
//
//  Created by Jorge Palomino on 12/01/2025.
//

import Foundation

public class OddsConverter {
    
    static let oddEvensKeyWord = "evens"
    
    private var oddDecimal: Double?
    private var odd: String?
    
    public init(odd: String? = nil) {
        if let odd = odd {
            self.setOdd(odd)
        }
    }
    
    public init(odd: CGFloat? = nil) {
        if let odd = odd {
            self.setOdd("\(odd)")
        }
    }
    
    public func setOdd(_ odd: String) {
        var oddValue = odd.lowercased()
        if oddValue == OddsConverter.oddEvensKeyWord {
            oddValue = "1/1"
        }
        
        if isDecimal(oddValue) { // Decimal detected
            self.oddDecimal = Double(oddValue)
        } else if oddValue.contains("/") { // Fractional detected
            self.oddDecimal = decimalFromFraction(oddValue)
        } else { // Assume moneyline (US format)
            self.oddDecimal = getDecimalFromMoneyLine(oddValue)
        }
        
        self.odd = oddValue
    }
    
    public func getFractional() -> String? {
        guard let oddDecimal = oddDecimal else { return nil }
        return getFractionalFromDecimal(oddDecimal)
    }
    
    public func getDecimal() -> String? {
        guard let oddDecimal = oddDecimal else { return nil }
        return String(format: "%.2f", oddDecimal)
    }
    
    public func getMoneyline() -> String? {
        guard let oddDecimal = oddDecimal else { return nil }
        return getMoneylineFromDecimal(oddDecimal)
    }
    
    private func isDecimal(_ val: String) -> Bool {
        if let number = Double(val) {
            return floor(number) != number
        }
        return false
    }
    
    private func decimalFromFraction(_ fraction: String) -> Double? {
        let components = fraction.split(separator: "/").map { String($0) }
        if components.count == 2, let numerator = Double(components[0]), let denominator = Double(components[1]), denominator != 0 {
            return (numerator / denominator) + 1
        }
        return nil
    }
    
    private func getFractionalFromDecimal(_ decimal: Double) -> String {
        let decimalValue = decimal - 1
        let num = round(decimalValue * 50)
        let dom = 50
        
        let reduced = reduce(num: Int(num), dom: dom)
        return "\(reduced.0)/\(reduced.1)"
    }
    
    private func getDecimalFromMoneyLine(_ moneyline: String) -> Double? {
        guard let moneylineValue = Double(moneyline) else { return nil }
        if moneylineValue > 0 {
            return (moneylineValue / 100) + 1
        } else {
            return (100 / abs(moneylineValue)) + 1
        }
    }
    
    private func getMoneylineFromDecimal(_ decimal: Double) -> String {
        let decimalValue = decimal - 1
        if decimalValue < 1 {
            return "-\(Int(100 / decimalValue))"
        } else {
            return "+\(Int(decimalValue * 100))"
        }
    }
    
    private func reduce(num: Int, dom: Int) -> (Int, Int) {
        let gcdValue = gcd(a: num, b: dom)
        return (num / gcdValue, dom / gcdValue)
    }
    
    private func gcd(a: Int, b: Int) -> Int {
        return (a % b) == 0 ? b : gcd(a: b, b: a % b)
    }
}
