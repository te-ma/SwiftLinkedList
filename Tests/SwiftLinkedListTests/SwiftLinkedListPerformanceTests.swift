//
//  SwiftLinkedListPerformanceTests.swift
//  SwiftLinkedList
//
//  Created by Artem Lebedev on 26/04/2020.
//

import XCTest
import Foundation
@testable import SwiftLinkedList

final class SwiftLinkedListPerformanceTests: XCTestCase {
    
    func testListAppendPerformance() {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            
            let list = LinkedList<Int>()
            
            startMeasuring()
            for i in 0...49999 {

                _ = list.append(i)

            }
            stopMeasuring()
        }
    }
    
    func testArrayAppendPerformance() {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            
            var arr = Array<Int>()
            
            startMeasuring()
            for i in 0...49999 {

                _ = arr.append(i)

            }
            stopMeasuring()
        }
    }
    
    func testListRemovePerformance() {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            
            let list = LinkedList<Int>()
            
            for i in 0...49999 {

                _ = list.append(i)

            }
            
            startMeasuring()
            for _ in 0..<1000 {

                _ = list.remove(at: 999)

            }
            stopMeasuring()
        }
    }
    
    func testArrayRemovePerformance() {
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false) {
            
            var arr = Array<Int>()
            
            for i in 0...49999 {

                _ = arr.append(i)

            }
            
            startMeasuring()
            for _ in 0..<1000 {

                _ = arr.remove(at: 999)

            }
            stopMeasuring()
        }
    }
}
