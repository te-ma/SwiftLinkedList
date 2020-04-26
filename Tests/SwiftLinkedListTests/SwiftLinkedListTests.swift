import XCTest
import Foundation
@testable import SwiftLinkedList

final class SwiftLinkedListTests: XCTestCase {
    func testCreateEmptyLinkedListWithoutElement() {
        let list = LinkedList<Int>()

        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }

    func testCreateLinkedListFromArray() {
        print("test")
        let list = LinkedList<Int>([1, 2, 3])

        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.head!.element, 1)
        XCTAssertEqual(list.head!.next!.element, 2)
        XCTAssertEqual(list.tail!.element, 3)
    }

    func testAppendSingleElement() {
        let list = LinkedList<Int>()
        let singleNode = list.append(1)

        XCTAssert(list.head === singleNode)
        XCTAssert(list.tail === singleNode)
        XCTAssertEqual(singleNode.element, 1)
        XCTAssertEqual(list.count, 1)
    }

    func testRemoveSingleElement() {
        let list = LinkedList<Int>()
        weak var singleNode = list.append(1)
        let removedElement = list.remove(singleNode!)

        XCTAssertEqual(removedElement, 1)
        XCTAssertNil(singleNode)
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
        XCTAssertEqual(list.count, 0)
    }

    func testAppendElementToExistingList() {
        let list = LinkedList<Int>([1, 2, 3])
        let newNode = list.append(4)

        XCTAssertEqual(list.count, 4)
        XCTAssert(list.tail === newNode)
    }

    func testRemoveElementFromExistingList() {
        let list = LinkedList<Int>([1, 2, 3])
        weak var newNode = list.append(4)
        let removedElement = list.remove(newNode!)

        XCTAssertNil(newNode)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(removedElement, 4)
        XCTAssertEqual(list.tail!.element, 3)
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
