/**
   - Complexity:
        - Traversal: O(n)
        - Access a known element: O(1)
        - Insert element: O(1)
        - Delete element: O(1)
*/

public class LinkedList<T> {

    public class ListNode<T> {
        var element: T
        weak var previous: ListNode?
        var next: ListNode?
        
        init(_ element: T) {
            self.element = element
            self.previous = nil
            self.next = nil
        }
    }
    
    public typealias Node = ListNode<T>
    
    private(set) var head: Node?
    private(set) var tail: Node?
    private(set) var count: Int
    
    public init() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
    
    public convenience init(_ elements: [T]) {
        self.init()
        
        for element in elements {
            _ = self.append(element)
        }
    }
    
    public func append(_ element: T) -> Node {
        let newNode = Node(element)
        self.append(newNode)
        
        return newNode
    }
    
    func append(_ node: Node) {
        
        if self.tail != nil {
            self.tail!.next = node
            node.previous = self.tail
            self.tail = node
        } else {
            self.head = node
            self.tail = node
        }
        
        self.count += 1
    }
    
    @discardableResult public func remove(_ node: Node) -> T? {
        if node === tail {
            self.tail = node.previous
        }
        
        if node === head {
            self.head = node.next
        }
        
        node.previous?.next = node.next
        node.next?.previous = node.previous
        
        self.count -= 1
        
        return node.element
    }
}

extension LinkedList: Sequence {
    public struct LinkedListIterator: IteratorProtocol {
        
        var currentNode: Node?
        
        init(_ head: Node?) {
            self.currentNode = head
        }
        
        public mutating func next() -> Node? {
            defer {
                self.currentNode = self.currentNode?.next
            }
            return self.currentNode
        }
    }
    
    public func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(self.head)
    }
}
