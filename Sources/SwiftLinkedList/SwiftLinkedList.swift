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

final public class LinkedList<T> {

    final public class ListNode<T> {
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
    
    var head: Node?
    var tail: Node?
    public private(set) var count: Int
    
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
        Adds a new node containing the element to the end of the list and  returns the new node.
        - Returns:
            Element of type `Node`.
     */
    @discardableResult public func append(_ element: T) -> Node {
        let newNode = Node(element)
        self.append(newNode)
        
        return newNode
    }
    
    /**
       Inserts a new node containing the element at the beginning of the list and  returns the new node.
       - Returns:
           Element of type `Node`.
    */
    @discardableResult public func prepend(_ element: T) -> Node {
        let newNode = Node(element)
        self.prepend(newNode)
        
        return newNode
    }
    
    /**
       Removes a given node from the list and returns the element stored in that node.
       - Returns:
           Element of type `T`.
    */
    @discardableResult public func remove(_ node: Node) -> T {
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
    
    /**
       Removes a node containing the element at a given index and returns the element stored in that node.
       - Returns:
           Element of type `T?`.
    */
    @discardableResult public func remove(at index: Int) -> T {
        
        guard index >= 0 && index < self.count else {
            fatalError("Index out of range!")
        }
        
        //Given the above checks, we can be sure that nodeToRemove will never be nil
        var nodeToRemove: Node!
        
        var iterator = self.makeIterator()
        var i = 0
        while let node = iterator.next() {
            if i == index {
                nodeToRemove = node
                break
            }
            i += 1
        }

        return self.remove(nodeToRemove)
    }
    
    //MARK: Private methods
    
    func append(_ node: Node) {
        
        if self.tail != nil {
            self.tail!.next = node
            node.previous = self.tail
            
        } else {
            self.head = node
        }
        
        self.tail = node
        self.count += 1
    }
    
    func prepend(_ node: Node) {
        if self.head != nil {
            self.head!.previous = node
            node.next = self.head
        } else {
            self.tail = node
        }
        
        self.head = node
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
