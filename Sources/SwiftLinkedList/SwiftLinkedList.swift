/**
   This framework implements a basic double-linked list data structure.
    - Complexity:
        - Append/prepend an element: *O(1)*
        - Access a known element: *O(1)*
        - Access an element by index: *O(n)*
        - Remove a known element: *O(1)*
        - Remove an element at index: *O(n)*
        - Traversal: *O(n)*
    - TODO:
        - Insert at index
*/

public class LinkedList<T> {

    public class ListNode<T> {
        public var element: T
        weak var previous: ListNode?
        var next: ListNode?
        
        init(_ element: T) {
            self.element = element
            self.previous = nil
            self.next = nil
        }
    }
    
    public typealias Node = ListNode<T>
    
    private var head: Node?
    private var tail: Node?
    private(set) var count: Int
    
    public init() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
    
//  Custom deinit to deallocate items in sequiential order
//  Default deinit will deallocate recursively causing stack overflow on large lists
    deinit {
        var i = self.makeIterator()
        self.head = nil
        while let node = i.next() {
            node.next?.previous = nil
            node.next = nil
        }
    }
    
    //MARK: Public methods
    
    /**
        Initializes a list using  an array of elements.
     */
    public convenience init(_ elements: [T]) {
        self.init()
        
        for element in elements {
            self.append(Node(element))
        }
    }
    
    /**
        Adds the element to the end of the list and returns the new element.
        - Returns:
            Element of type `Node`.
     */
    public func append(_ element: T) -> Node {
        let newNode = Node(element)
        self.append(newNode)
        
        return newNode
    }
    
    /**
       Adds the element to the end of the list and returns an index of the new element.
       - Returns:
           An index of the new element.
    */
    public func append(_ element: T) -> Int {
        let newNode = Node(element)
        self.append(newNode)
        
        return self.count
    }
    
    /**
       Inserts the element to the beginning of the list and returns the new element.
       - Returns:
           Element of type `Node`.
    */
    public func prepend(_ element: T) -> Node {
        let newNode = Node(element)
        self.prepend(newNode)
        
        return newNode
    }
    
    /**
       Inserts the element to the beginning of the list and returns an index of the new element.
       - Returns:
           An index of the new element.
    */
    public func prepend(_ element: T) -> Int {
        let newNode = Node(element)
        self.prepend(newNode)
        
        return self.count
    }
    
    public func remove(at index: Int) {
        var i = 0

        for node in self {
            if i == index {
                self.remove(node)
                return
            }
            i += 1
        }
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
    
//    MARK: Private methods
    
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
    
    func prepend(_ node: Node) {
        if self.head != nil {
            self.head!.previous = node
            node.next = self.head
            self.head = node
        } else {
            self.head = node
            self.tail = node
        }
        self.count += 1
    }
}

//Implements Sequence protocol to enable loop traversal

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
