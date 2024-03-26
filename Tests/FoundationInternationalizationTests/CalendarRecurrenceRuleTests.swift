//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if canImport(TestSupport)
import TestSupport
#endif

#if FOUNDATION_FRAMEWORK
@testable import Foundation
#else
@testable import FoundationInternationalization
@testable import FoundationEssentials
#endif // FOUNDATION_FRAMEWORK

@available(FoundationPreview 0.4, *)
final class CalendarRecurrenceRuleTests: XCTestCase {
    /// A Gregorian calendar with a time zone set to California
    var gregorian: Calendar = {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = .init(identifier: "US/Pacific")!
        return gregorian
    }()
  
    func testRoundtripEncoding() throws {
        // These are not necessarily valid recurrence rule, they are constructed
        // in a way to test all encoding paths
        var recurrenceRule1 = Calendar.RecurrenceRule(calendar: .current, frequency: .daily)
        recurrenceRule1.interval = 2
        recurrenceRule1.months = [1, 2, Calendar.RecurrenceRule.Month(4, isLeap: true)]
        recurrenceRule1.weeks = [2, 3]
        recurrenceRule1.weekdays = [.every(.monday), .nth(1, .wednesday)]
        recurrenceRule1.end = .afterOccurrences(5)
        
        var recurrenceRule2 = Calendar.RecurrenceRule(calendar: .init(identifier: .gregorian), frequency: .daily)
        recurrenceRule2.months = [2, 10]
        recurrenceRule2.weeks = [1, -1]
        recurrenceRule2.setPositions = [1]
        recurrenceRule2.hours = [14]
        recurrenceRule2.minutes = [30]
        recurrenceRule2.seconds = [0]
        recurrenceRule2.daysOfTheYear = [1]
        recurrenceRule2.daysOfTheMonth = [4]
        recurrenceRule2.weekdays = [.every(.monday), .nth(1, .wednesday)]
        recurrenceRule2.end = .afterDate(.distantFuture)
        
        let recurrenceRule1JSON = try JSONEncoder().encode(recurrenceRule1)
        let recurrenceRule2JSON = try JSONEncoder().encode(recurrenceRule2)
        let decoded1 = try JSONDecoder().decode(Calendar.RecurrenceRule.self, from: recurrenceRule1JSON)
        let decoded2 = try JSONDecoder().decode(Calendar.RecurrenceRule.self, from: recurrenceRule2JSON)
        
        XCTAssertEqual(recurrenceRule1, decoded1)
        XCTAssertEqual(recurrenceRule2, decoded2)
        XCTAssertNotEqual(recurrenceRule1, recurrenceRule2)
    }
    
    func testSimpleDailyRecurrence() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        let rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily, end: .never)
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1285189200.0), // 2010-09-22T14:00:00-0700
            Date(timeIntervalSince1970: 1285275600.0), // 2010-09-23T14:00:00-0700
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285448400.0), // 2010-09-25T14:00:00-0700
            Date(timeIntervalSince1970: 1285534800.0), // 2010-09-26T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1285707600.0), // 2010-09-28T14:00:00-0700
            Date(timeIntervalSince1970: 1285794000.0), // 2010-09-29T14:00:00-0700
            Date(timeIntervalSince1970: 1285880400.0), // 2010-09-30T14:00:00-0700
            Date(timeIntervalSince1970: 1285966800.0), // 2010-10-01T14:00:00-0700
            Date(timeIntervalSince1970: 1286053200.0), // 2010-10-02T14:00:00-0700
            Date(timeIntervalSince1970: 1286139600.0), // 2010-10-03T14:00:00-0700
            Date(timeIntervalSince1970: 1286226000.0), // 2010-10-04T14:00:00-0700
            Date(timeIntervalSince1970: 1286312400.0), // 2010-10-05T14:00:00-0700
            Date(timeIntervalSince1970: 1286398800.0), // 2010-10-06T14:00:00-0700
            Date(timeIntervalSince1970: 1286485200.0), // 2010-10-07T14:00:00-0700
            Date(timeIntervalSince1970: 1286571600.0), // 2010-10-08T14:00:00-0700
            Date(timeIntervalSince1970: 1286658000.0), // 2010-10-09T14:00:00-0700
            Date(timeIntervalSince1970: 1286744400.0), // 2010-10-10T14:00:00-0700
            Date(timeIntervalSince1970: 1286830800.0), // 2010-10-11T14:00:00-0700
            Date(timeIntervalSince1970: 1286917200.0), // 2010-10-12T14:00:00-0700
            Date(timeIntervalSince1970: 1287003600.0), // 2010-10-13T14:00:00-0700
            Date(timeIntervalSince1970: 1287090000.0), // 2010-10-14T14:00:00-0700
            Date(timeIntervalSince1970: 1287176400.0), // 2010-10-15T14:00:00-0700
            Date(timeIntervalSince1970: 1287262800.0), // 2010-10-16T14:00:00-0700
            Date(timeIntervalSince1970: 1287349200.0), // 2010-10-17T14:00:00-0700
            Date(timeIntervalSince1970: 1287435600.0), // 2010-10-18T14:00:00-0700
            Date(timeIntervalSince1970: 1287522000.0), // 2010-10-19T14:00:00-0700
            Date(timeIntervalSince1970: 1287608400.0), // 2010-10-20T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testSimpleDailyRecurrenceWithCount() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        let rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily, end: .afterOccurrences(4))
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1285189200.0), // 2010-09-22T14:00:00-0700
            Date(timeIntervalSince1970: 1285275600.0), // 2010-09-23T14:00:00-0700
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testDailyRecurrenceWithDaysOfTheWeek() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.weekdays = [.every(.monday), .every(.friday)]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1285966800.0), // 2010-10-01T14:00:00-0700
            Date(timeIntervalSince1970: 1286226000.0), // 2010-10-04T14:00:00-0700
            Date(timeIntervalSince1970: 1286571600.0), // 2010-10-08T14:00:00-0700
            Date(timeIntervalSince1970: 1286830800.0), // 2010-10-11T14:00:00-0700
            Date(timeIntervalSince1970: 1287176400.0), // 2010-10-15T14:00:00-0700
            Date(timeIntervalSince1970: 1287435600.0), // 2010-10-18T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testDailyRecurrenceWithDaysOfTheWeekAndMonth() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.weekdays = [.every(.monday), .every(.friday)]
        rule.months = [9]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testDailyRecurrenceWithMonth() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.months = [9]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1285189200.0), // 2010-09-22T14:00:00-0700
            Date(timeIntervalSince1970: 1285275600.0), // 2010-09-23T14:00:00-0700
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285448400.0), // 2010-09-25T14:00:00-0700
            Date(timeIntervalSince1970: 1285534800.0), // 2010-09-26T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1285707600.0), // 2010-09-28T14:00:00-0700
            Date(timeIntervalSince1970: 1285794000.0), // 2010-09-29T14:00:00-0700
            Date(timeIntervalSince1970: 1285880400.0), // 2010-09-30T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testDailyRecurrenceEveryThreeDays() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.interval = 3
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1285880400.0), // 2010-09-30T14:00:00-0700
            Date(timeIntervalSince1970: 1286139600.0), // 2010-10-03T14:00:00-0700
            Date(timeIntervalSince1970: 1286398800.0), // 2010-10-06T14:00:00-0700
            Date(timeIntervalSince1970: 1286658000.0), // 2010-10-09T14:00:00-0700
            Date(timeIntervalSince1970: 1286917200.0), // 2010-10-12T14:00:00-0700
            Date(timeIntervalSince1970: 1287176400.0), // 2010-10-15T14:00:00-0700
            Date(timeIntervalSince1970: 1287435600.0), // 2010-10-18T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
        
    }
    
    func testSimpleWeeklyRecurrence() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        let rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .weekly)
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1285707600.0), // 2010-09-28T14:00:00-0700
            Date(timeIntervalSince1970: 1286312400.0), // 2010-10-05T14:00:00-0700
            Date(timeIntervalSince1970: 1286917200.0), // 2010-10-12T14:00:00-0700
            Date(timeIntervalSince1970: 1287522000.0), // 2010-10-19T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testWeeklyRecurrenceEveryOtherWeek() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .weekly)
        rule.interval = 2
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285102800.0), // 2010-09-21T14:00:00-0700
            Date(timeIntervalSince1970: 1286312400.0), // 2010-10-05T14:00:00-0700
            Date(timeIntervalSince1970: 1287522000.0), // 2010-10-19T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testWeeklyRecurrenceWithDaysOfWeek() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .weekly)
        rule.weekdays = [.every(.monday), .every(.friday)]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1285966800.0), // 2010-10-01T14:00:00-0700
            Date(timeIntervalSince1970: 1286226000.0), // 2010-10-04T14:00:00-0700
            Date(timeIntervalSince1970: 1286571600.0), // 2010-10-08T14:00:00-0700
            Date(timeIntervalSince1970: 1286830800.0), // 2010-10-11T14:00:00-0700
            Date(timeIntervalSince1970: 1287176400.0), // 2010-10-15T14:00:00-0700
            Date(timeIntervalSince1970: 1287435600.0), // 2010-10-18T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testWeeklyRecurrenceWithDaysOfWeekAndMonth() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .weekly)
        rule.months = [9]
        rule.weekdays = [.every(.monday), .every(.friday)]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285621200.0), // 2010-09-27T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    func testWeeklyRecurrenceWithDaysOfWeekAndSetPositions() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1287644400.0) // 2010-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .weekly)
        rule.setPositions = [-1]
        rule.weekdays = [.every(.monday), .every(.friday)]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1285362000.0), // 2010-09-24T14:00:00-0700
            Date(timeIntervalSince1970: 1285966800.0), // 2010-10-01T14:00:00-0700
            Date(timeIntervalSince1970: 1286571600.0), // 2010-10-08T14:00:00-0700
            Date(timeIntervalSince1970: 1287176400.0), // 2010-10-15T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testMonthlyRecurrenceWithWeekdays() {
        // Find the first monday and last friday of each month for a given range
        let start = Date(timeIntervalSince1970: 1641074400.0) // 2022-01-01T14:00:00-0800
        let end   = Date(timeIntervalSince1970: 1677708000.0) // 2023-03-01T14:00:00-0800
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .monthly)
        rule.end = .afterDate(end)
        rule.weekdays = [.nth(1, .monday), .nth(-1, .friday)]
        
        let results = Array(rule.recurrences(of: start))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1641247200.0), // 2022-01-03T14:00:00-0800
            Date(timeIntervalSince1970: 1643407200.0), // 2022-01-28T14:00:00-0800
            Date(timeIntervalSince1970: 1644271200.0), // 2022-02-07T14:00:00-0800
            Date(timeIntervalSince1970: 1645826400.0), // 2022-02-25T14:00:00-0800
            Date(timeIntervalSince1970: 1646690400.0), // 2022-03-07T14:00:00-0800
            Date(timeIntervalSince1970: 1648242000.0), // 2022-03-25T14:00:00-0700
            Date(timeIntervalSince1970: 1649106000.0), // 2022-04-04T14:00:00-0700
            Date(timeIntervalSince1970: 1651266000.0), // 2022-04-29T14:00:00-0700
            Date(timeIntervalSince1970: 1651525200.0), // 2022-05-02T14:00:00-0700
            Date(timeIntervalSince1970: 1653685200.0), // 2022-05-27T14:00:00-0700
            Date(timeIntervalSince1970: 1654549200.0), // 2022-06-06T14:00:00-0700
            Date(timeIntervalSince1970: 1656104400.0), // 2022-06-24T14:00:00-0700
            Date(timeIntervalSince1970: 1656968400.0), // 2022-07-04T14:00:00-0700
            Date(timeIntervalSince1970: 1659128400.0), // 2022-07-29T14:00:00-0700
            Date(timeIntervalSince1970: 1659387600.0), // 2022-08-01T14:00:00-0700
            Date(timeIntervalSince1970: 1661547600.0), // 2022-08-26T14:00:00-0700
            Date(timeIntervalSince1970: 1662411600.0), // 2022-09-05T14:00:00-0700
            Date(timeIntervalSince1970: 1664571600.0), // 2022-09-30T14:00:00-0700
            Date(timeIntervalSince1970: 1664830800.0), // 2022-10-03T14:00:00-0700
            Date(timeIntervalSince1970: 1666990800.0), // 2022-10-28T14:00:00-0700
            Date(timeIntervalSince1970: 1667858400.0), // 2022-11-07T14:00:00-0800
            Date(timeIntervalSince1970: 1669413600.0), // 2022-11-25T14:00:00-0800
            Date(timeIntervalSince1970: 1670277600.0), // 2022-12-05T14:00:00-0800
            Date(timeIntervalSince1970: 1672437600.0), // 2022-12-30T14:00:00-0800
            Date(timeIntervalSince1970: 1672696800.0), // 2023-01-02T14:00:00-0800
            Date(timeIntervalSince1970: 1674856800.0), // 2023-01-27T14:00:00-0800
            Date(timeIntervalSince1970: 1675720800.0), // 2023-02-06T14:00:00-0800
            Date(timeIntervalSince1970: 1677276000.0), // 2023-02-24T14:00:00-0800
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceOnLeapDay() {
        let start   = Date(timeIntervalSince1970: 1704096000.0) // 2024-01-01T00:00:00-0800
        let end     = Date(timeIntervalSince1970: 1956556800.0) // 2032-01-01T00:00:00-0800
        let leapDay = Date(timeIntervalSince1970: 1709229600.0) // 2024-02-29T10:00:00-0800
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        var results, expectedResults: [Date]
        
        rule.matchingPolicy = .nextTimePreservingSmallerComponents
        results = Array(rule.recurrences(of: leapDay, in: start..<end))
        expectedResults = [
            Date(timeIntervalSince1970: 1709229600.0), // 2024-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1740852000.0), // 2025-03-01T10:00:00-0800
            Date(timeIntervalSince1970: 1772388000.0), // 2026-03-01T10:00:00-0800
            Date(timeIntervalSince1970: 1803924000.0), // 2027-03-01T10:00:00-0800
            Date(timeIntervalSince1970: 1835460000.0), // 2028-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1867082400.0), // 2029-03-01T10:00:00-0800
            Date(timeIntervalSince1970: 1898618400.0), // 2030-03-01T10:00:00-0800
            Date(timeIntervalSince1970: 1930154400.0), // 2031-03-01T10:00:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
        
        rule.matchingPolicy = .nextTime
        results = Array(rule.recurrences(of: leapDay, in: start..<end))
        expectedResults = [
            Date(timeIntervalSince1970: 1709229600.0), // 2024-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1740816000.0), // 2025-03-01T00:00:00-0800
            Date(timeIntervalSince1970: 1772352000.0), // 2026-03-01T00:00:00-0800
            Date(timeIntervalSince1970: 1803888000.0), // 2027-03-01T00:00:00-0800
            Date(timeIntervalSince1970: 1835460000.0), // 2028-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1867046400.0), // 2029-03-01T00:00:00-0800
            Date(timeIntervalSince1970: 1898582400.0), // 2030-03-01T00:00:00-0800
            Date(timeIntervalSince1970: 1930118400.0), // 2031-03-01T00:00:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
        
        rule.matchingPolicy = .previousTimePreservingSmallerComponents
        results = Array(rule.recurrences(of: leapDay, in: start..<end))
        expectedResults = [
            Date(timeIntervalSince1970: 1709229600.0), // 2024-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1740765600.0), // 2025-02-28T10:00:00-0800
            Date(timeIntervalSince1970: 1772301600.0), // 2026-02-28T10:00:00-0800
            Date(timeIntervalSince1970: 1803837600.0), // 2027-02-28T10:00:00-0800
            Date(timeIntervalSince1970: 1835460000.0), // 2028-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1866996000.0), // 2029-02-28T10:00:00-0800
            Date(timeIntervalSince1970: 1898532000.0), // 2030-02-28T10:00:00-0800
            Date(timeIntervalSince1970: 1930068000.0), // 2031-02-28T10:00:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
        
        rule.matchingPolicy = .strict
        results = Array(rule.recurrences(of: leapDay, in: start..<end))
        expectedResults = [
            Date(timeIntervalSince1970: 1709229600.0), // 2024-02-29T10:00:00-0800
            Date(timeIntervalSince1970: 1835460000.0), // 2028-02-29T10:00:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceWithMonthExpansion() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1350802800.0) // 2012-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.months = [1, 5]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1295647200.0), // 2011-01-21T14:00:00-0800
            Date(timeIntervalSince1970: 1306011600.0), // 2011-05-21T14:00:00-0700
            Date(timeIntervalSince1970: 1327183200.0), // 2012-01-21T14:00:00-0800
            Date(timeIntervalSince1970: 1337634000.0), // 2012-05-21T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    func testYearlyRecurrenceWithDayOfMonthExpansion() {
        let start = Date(timeIntervalSince1970: 1695330000.0) // 2023-09-21T14:00:00-0700
        let end   = Date(timeIntervalSince1970: 1729544400.0) // 2024-10-21T14:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.daysOfTheMonth = [1, -1]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1696107600.0), // 2023-09-30T14:00:00-0700
            Date(timeIntervalSince1970: 1725224400.0), // 2024-09-01T14:00:00-0700
            Date(timeIntervalSince1970: 1727730000.0), // 2024-09-30T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceWithMonthAndDayOfMonthExpansion() {
        let start = Date(timeIntervalSince1970: 1285052400.0) // 2010-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1350802800.0) // 2012-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.months = [1, 5]
        rule.daysOfTheMonth = [3, 10]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1294092000.0), // 2011-01-03T14:00:00-0800
            Date(timeIntervalSince1970: 1294696800.0), // 2011-01-10T14:00:00-0800
            Date(timeIntervalSince1970: 1304456400.0), // 2011-05-03T14:00:00-0700
            Date(timeIntervalSince1970: 1305061200.0), // 2011-05-10T14:00:00-0700
            Date(timeIntervalSince1970: 1325628000.0), // 2012-01-03T14:00:00-0800
            Date(timeIntervalSince1970: 1326232800.0), // 2012-01-10T14:00:00-0800
            Date(timeIntervalSince1970: 1336078800.0), // 2012-05-03T14:00:00-0700
            Date(timeIntervalSince1970: 1336683600.0), // 2012-05-10T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }    
    func testYearlyRecurrenceWithMonthAndWeekdayExpansion() {
        let start = Date(timeIntervalSince1970: 1704146400.0) // 2024-01-01T14:00:00-0800
        let end   = Date(timeIntervalSince1970: 1767254400.0) // 2026-01-01T00:00:00-0800
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.months = [5, 9]
        rule.weekdays = [.nth(1, .monday), .nth(-1, .friday)]
        
        let results = Array(rule.recurrences(of: start, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1715029200.0), // 2024-05-06T14:00:00-0700
            Date(timeIntervalSince1970: 1717189200.0), // 2024-05-31T14:00:00-0700
            Date(timeIntervalSince1970: 1725310800.0), // 2024-09-02T14:00:00-0700
            Date(timeIntervalSince1970: 1727470800.0), // 2024-09-27T14:00:00-0700
            Date(timeIntervalSince1970: 1746478800.0), // 2025-05-05T14:00:00-0700
            Date(timeIntervalSince1970: 1748638800.0), // 2025-05-30T14:00:00-0700
            Date(timeIntervalSince1970: 1756760400.0), // 2025-09-01T14:00:00-0700
            Date(timeIntervalSince1970: 1758920400.0), // 2025-09-26T14:00:00-0700
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceWithWeekNumberExpansion() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // Week starts on Monday
        
        let start = Date(timeIntervalSince1970: 1704146400.0) // 2024-01-01T14:00:00-0800
        let end   = Date(timeIntervalSince1970: 1767254400.0) // 2026-01-01T00:00:00-0800
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.weeks = [1, -1]
        
        let results = Array(rule.recurrences(of: start, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1704146400.0), // 2024-01-01T14:00:00-0800
            Date(timeIntervalSince1970: 1734991200.0), // 2024-12-23T14:00:00-0800
            Date(timeIntervalSince1970: 1735768800.0), // 2025-01-01T14:00:00-0800
            Date(timeIntervalSince1970: 1766613600.0), // 2025-12-24T14:00:00-0800
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceWithDayOfYearExpansion() {
        let start = Date(timeIntervalSince1970: 1695279600.0) // 2023-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1729494000.0) // 2024-10-21T00:00:00-0700
        
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.daysOfTheYear = [1, -1]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1704060000.0), // 2023-12-31T14:00:00-0800
            Date(timeIntervalSince1970: 1704146400.0), // 2024-01-01T14:00:00-0800
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    func testYearlyRecurrenceInLunarCalendar() {
        // Find the first day of the lunar new year
        let start = Date(timeIntervalSince1970: 1726902000.0) // 2024-09-21T00:00:00-0700
        let end   = Date(timeIntervalSince1970: 1855724400.0) // 2028-10-21T00:00:00-0700
        
        let lunarCalendar = Calendar(identifier: .chinese)
        var rule = Calendar.RecurrenceRule(calendar: lunarCalendar, frequency: .yearly)
        rule.daysOfTheYear = [1]
        
        let eventStart = Date(timeIntervalSince1970: 1285102800.0) // 2010-09-21T14:00:00-0700
        let results = Array(rule.recurrences(of: eventStart, in: start..<end))
        
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1738188000.0), // 2025-01-29T14:00:00-0800
            Date(timeIntervalSince1970: 1771365600.0), // 2026-02-17T14:00:00-0800
            Date(timeIntervalSince1970: 1801951200.0), // 2027-02-06T14:00:00-0800
            Date(timeIntervalSince1970: 1832536800.0), // 2028-01-26T14:00:00-0800
        ]
        
        XCTAssertEqual(results, expectedResults)
    }
    
    
    func testHourlyRecurrenceWithWeekdayFilter() {
        // Repeat hourly, but filter to Sundays
        let start = Date(timeIntervalSince1970: 1590339600.0) // 2020-05-24T10:00:00-0700
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .hourly)
        rule.weekdays = [.every(.sunday)]
        rule.end = .afterOccurrences(16) 
        let results = Array(rule.recurrences(of: start))
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1590339600.0), // 2020-05-24T10:00:00-0700
            Date(timeIntervalSince1970: 1590343200.0), // 2020-05-24T11:00:00-0700
            Date(timeIntervalSince1970: 1590346800.0), // 2020-05-24T12:00:00-0700
            Date(timeIntervalSince1970: 1590350400.0), // 2020-05-24T13:00:00-0700
            Date(timeIntervalSince1970: 1590354000.0), // 2020-05-24T14:00:00-0700
            Date(timeIntervalSince1970: 1590357600.0), // 2020-05-24T15:00:00-0700
            Date(timeIntervalSince1970: 1590361200.0), // 2020-05-24T16:00:00-0700
            Date(timeIntervalSince1970: 1590364800.0), // 2020-05-24T17:00:00-0700
            Date(timeIntervalSince1970: 1590368400.0), // 2020-05-24T18:00:00-0700
            Date(timeIntervalSince1970: 1590372000.0), // 2020-05-24T19:00:00-0700
            Date(timeIntervalSince1970: 1590375600.0), // 2020-05-24T20:00:00-0700
            Date(timeIntervalSince1970: 1590379200.0), // 2020-05-24T21:00:00-0700
            Date(timeIntervalSince1970: 1590382800.0), // 2020-05-24T22:00:00-0700
            Date(timeIntervalSince1970: 1590386400.0), // 2020-05-24T23:00:00-0700
            Date(timeIntervalSince1970: 1590908400.0), // 2020-05-31T00:00:00-0700
            Date(timeIntervalSince1970: 1590912000.0), // 2020-05-31T01:00:00-0700
        ]

        XCTAssertEqual(results, expectedResults)
    }
    func testHourlyRecurrenceWithHourAndWeekdayFilter() {
        // Repeat hourly, filter to 10am on the last Sunday of the month
        let start = Date(timeIntervalSince1970: 1590339600.0) // 2020-05-24T10:00:00-0700
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .hourly)
        rule.weekdays = [.nth(-1, .sunday)]
        rule.hours = [11]
        rule.end = .afterOccurrences(4) 
        let results = Array(rule.recurrences(of: start))
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1590948000.0), // 2020-05-31T11:00:00-0700
            Date(timeIntervalSince1970: 1593367200.0), // 2020-06-28T11:00:00-0700
            Date(timeIntervalSince1970: 1595786400.0), // 2020-07-26T11:00:00-0700
            Date(timeIntervalSince1970: 1598810400.0), // 2020-08-30T11:00:00-0700
        ]

        XCTAssertEqual(results, expectedResults)
    }
    func testDailyRecurrenceWithHourlyExpansions() {
        // Repeat hourly, filter to 10am on the last Sunday of the month
        let start = Date(timeIntervalSince1970: 1590332400.0) // 2020-05-24T08:00:00-0700
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.hours = [9, 10]
        rule.minutes = [0, 30]
        rule.seconds = [0, 30]
        rule.end = .afterOccurrences(10)
        let results = Array(rule.recurrences(of: start))
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1590336000.0), // 2020-05-24T09:00:00-0700
            Date(timeIntervalSince1970: 1590336030.0), // 2020-05-24T09:00:30-0700
            Date(timeIntervalSince1970: 1590337800.0), // 2020-05-24T09:30:00-0700
            Date(timeIntervalSince1970: 1590337830.0), // 2020-05-24T09:30:30-0700
            Date(timeIntervalSince1970: 1590339600.0), // 2020-05-24T10:00:00-0700
            Date(timeIntervalSince1970: 1590339630.0), // 2020-05-24T10:00:30-0700
            Date(timeIntervalSince1970: 1590341400.0), // 2020-05-24T10:30:00-0700
            Date(timeIntervalSince1970: 1590341430.0), // 2020-05-24T10:30:30-0700
            Date(timeIntervalSince1970: 1590422400.0), // 2020-05-25T09:00:00-0700
            Date(timeIntervalSince1970: 1590422430.0), // 2020-05-25T09:00:30-0700
        ]
        XCTAssertEqual(results, expectedResults)
   }
   
   func testDaylightSavingsRepeatedTimePolicyFirst() {
        let start = Date(timeIntervalSince1970: 1730535600.0) // 2024-11-02T01:20:00-0700
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.repeatedTimePolicy = .first
        rule.end = .afterOccurrences(3)
        let results = Array(rule.recurrences(of: start))
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1730535600.0), // 2024-11-02T01:20:00-0700
            Date(timeIntervalSince1970: 1730622000.0), // 2024-11-03T01:20:00-0700
            ///   (Time zone switches from PST to PDT - clock jumps back one hour at
            ///    02:00 PDT)
            Date(timeIntervalSince1970: 1730712000.0), // 2024-11-04T01:20:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
   }
    
   func testDaylightSavingsRepeatedTimePolicyLast() {
        let start = Date(timeIntervalSince1970: 1730535600.0) // 2024-11-02T01:20:00-0700
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .daily)
        rule.repeatedTimePolicy = .last
        rule.end = .afterOccurrences(3)
        let results = Array(rule.recurrences(of: start))
        let expectedResults: [Date] = [
            Date(timeIntervalSince1970: 1730535600.0), // 2024-11-02T01:20:00-0700
            ///   (Time zone switches from PST to PDT - clock jumps back one hour at
            ///    02:00 PDT)
            Date(timeIntervalSince1970: 1730625600.0), // 2024-11-03T01:20:00-0800
            Date(timeIntervalSince1970: 1730712000.0), // 2024-11-04T01:20:00-0800
        ]
        XCTAssertEqual(results, expectedResults)
   }
   
   func testEmptySequence() {
        // Construct a recurrence rule which requests matches on the 32nd of May
        let start = Date(timeIntervalSince1970: 1704096000.0) // 2024-01-01T00:00:00-0800
        var rule = Calendar.RecurrenceRule(calendar: gregorian, frequency: .yearly)
        rule.months = [5]
        rule.daysOfTheMonth = [32]
        rule.matchingPolicy = .strict

        for _ in rule.recurrences(of: start) {
            XCTFail("Recurrence rule is not expected to produce results")
        }
        // If we get here, there isn't an infinite loop
   }
}
