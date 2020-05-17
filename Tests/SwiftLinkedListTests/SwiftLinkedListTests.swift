import XCTest
import Foundation
@testable import SwiftLinkedList

final class SwiftLinkedListTests: XCTestCase {
    func testCreateEmptyLinkedList() {
        let list = LinkedList<Int>()

        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }

    func testCreateLinkedListFromArray() {
        let list = LinkedList<Int>([1, 2, 3])

        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.head!.element, 1)
        XCTAssertEqual(list.head!.next!.element, 2)
        XCTAssertEqual(list.tail!.element, 3)
    }

    func testAppendElementToEmptyList() {
        let list = LinkedList<Int>()
        let singleNode = list.append(1)

        XCTAssert(list.head === singleNode)
        XCTAssert(list.tail === singleNode)
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.tail!.next)
        XCTAssertEqual(singleNode.element, 1)
        XCTAssertEqual(list.count, 1)
    }

    func testAppendElementToExistingList() {
        let list = LinkedList<Int>([1, 2, 3])
        let newNode = list.append(4)

        XCTAssertEqual(list.count, 4)
        XCTAssert(list.tail === newNode)
        XCTAssertEqual(list.tail!.element, 4)
        XCTAssertEqual(list.head!.element, 1)
    }
    
    func testPrependElementToEmptyList() {
        let list = LinkedList<Int>()
        let singleNode = list.prepend(1)

        XCTAssert(list.head === singleNode)
        XCTAssert(list.tail === singleNode)
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.tail!.next)
        XCTAssertEqual(singleNode.element, 1)
        XCTAssertEqual(list.count, 1)
    }

    func testPrependElementToExistingList() {
        let list = LinkedList<Int>([2, 3, 4])
        let newNode = list.prepend(1)

        XCTAssertEqual(list.count, 4)
        XCTAssert(list.head === newNode)
        XCTAssertEqual(list.head!.next!.element, 2)
        XCTAssert(list.head!.next!.previous! === list.head)
        
    }
    
    func testRemoveHeadElementFromList() {
        let list = LinkedList<Int>([1, 2, 3])
        let removedElement = list.remove(list.head!)

        XCTAssertEqual(list.head!.element, 2)
        XCTAssertNil(list.head!.previous)
        XCTAssert(list.head!.next === list.tail)
        XCTAssert(list.tail!.previous === list.head)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(removedElement, 1)
    }
    
    func testRemoveElementAtIndexFromList() {
        let list = LinkedList<Int>([1, 2, 3])
        let removedElement = list.remove(at: 1)

        XCTAssertEqual(removedElement, 2)
        XCTAssertEqual(list.head!.element, 1)
        XCTAssertEqual(list.tail!.element, 3)
        XCTAssert(list.head!.next === list.tail)
        XCTAssert(list.tail!.previous === list.head)
        XCTAssertEqual(list.count, 2)
    }

    func testRemoveTailElementFromList() {
        let list = LinkedList<Int>([1, 2, 3])
        let removedElement = list.remove(list.tail!)

        XCTAssertEqual(list.tail!.element, 2)
        XCTAssertNil(list.tail!.next)
        XCTAssert(list.head!.next === list.tail)
        XCTAssert(list.tail!.previous === list.head)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(removedElement, 3)
    }

    func testIterateOverLinkedList() {
        let list = LinkedList<Int>([1, 2, 3])
        var elementArray = [Int]()

        for node in list {
            elementArray.append(node.element)
        }

        XCTAssert(elementArray.elementsEqual([1, 2, 3]))
    }
}
