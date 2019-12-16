import Foundation

//MARK: - Craph

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    associatedtype Element
    //Creates a vertex and adds it to the graph.
    func createVertex(data: Element) -> Vertex<Element>
    //Adds a directed edge between two vertices.
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    //Adds an undirected (or bi-directional) edge between two vertices.
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    //Uses EdgeType to add either a directed or undirected edge between two vertices.
    func add(_ edge: EdgeType,
             from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    //Returns a list of outgoing edges from a specific vertex.
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    //Returns the weight of the edge between two vertices. In the following sections, you’ll implement this protocol in two ways:
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

//MARK: Vertex

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable where T: Hashable {}

extension Vertex: Equatable where T: Equatable {}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}

//MARK: Edge

public struct Edge<T> {
    
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

//MARK: Implementation

public class AdjacencyList<T: Hashable>: Graph {
    
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    public init() {}
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>,
                                to destination: Vertex<T>,
                                weight: Double?) {
        let edge = Edge(source: source,
                        destination: destination,
                        weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    public func add(_ edge: EdgeType,
                    from source: Vertex<Element>,
                    to destination: Vertex<Element>,
                    weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
        return edges(from: source).first { $0.destination == destination }? .weight
    }
    
}

extension Graph {
    
    public func addUndirectedEdge(between source: Vertex<Element>,
                                  and destination: Vertex<Element>,
                                  weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension AdjacencyList: CustomStringConvertible {
    
    public var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 { edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n")
        }
        return result
    }
}

//MARK: Adjacency matrix

public class AdjacencyMatrix<T>: Graph {
    
    private var vertices: [Vertex<T>] = []
    private var weights: [[Double?]] = []
    
    public init() {}
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        for i in 0..<weights.count { weights[i].append(nil) }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }
    
    public func add(_ edge: EdgeType,
                    from source: Vertex<T>,
                    to destination: Vertex<T>,
                    weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
    
    public func addDirectedEdge(from source: Vertex<T>,
                                to destination: Vertex<T>,
                                weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source,
                                  destination: vertices[column],
                                  weight: weight))
            }
        }
        return edges
    }
    
    
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
        return weights[source.index][destination.index]
    }
    
}

extension AdjacencyMatrix: CustomStringConvertible {
    
    public var description: String {
        let verticesDescription = vertices.map { ("\($0)") }.joined(separator: "\n")
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDescription = grid.joined(separator: "\n")
        return "\(verticesDescription)\n\n\(edgesDescription)"
    }
}

//MARK: - Breadth-First Search (обход в ширину)

public protocol Queue {
    
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueStack<T>: Queue {
    
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    public init() {}
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}

extension Graph where Element: Hashable {
    
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        queue.enqueue(source)
        enqueued.insert(source)
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            neighborEdges.forEach { edge in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        return visited
    }
}

//MARK: - Depth-First Search (обход в глубину)

public struct Stack<Element> {
    private var storage: [Element] = []
    public init() { }
    
    public init(_ elements: [Element]) {
      storage = elements
    }
}

extension Stack: CustomStringConvertible {
    
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n-----------"
        let stackElements = storage
            .map { "\($0)" }
            .reversed()
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
}

extension Stack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension Graph where Element: Hashable {
    
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        
        var stack: Stack<Vertex<Element>> = []
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        outer: while let vertex = stack.peek() {
            let neighbors = edges(from: vertex)
            guard !neighbors.isEmpty else {
                stack.pop()
                continue
            }
            for edge in neighbors {
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    visited.append(edge.destination)
                    continue outer
                }
            }
            stack.pop()
        }
        return visited
    }
}


//MARK: -

let graph = AdjacencyList<String>()
let a = graph.createVertex(data: "A")
let b = graph.createVertex(data: "B")
let c = graph.createVertex(data: "C")
let d = graph.createVertex(data: "D")
let e = graph.createVertex(data: "E")

graph.add(.directed, from: a, to: b, weight: 0)
graph.add(.directed, from: a, to: d, weight: 0)
graph.add(.directed, from: b, to: c, weight: 0)
graph.add(.directed, from: b, to: d, weight: 0)
graph.add(.directed, from: c, to: d, weight: 0)
graph.add(.directed, from: b, to: e, weight: 0)
graph.add(.directed, from: d, to: e, weight: 0)

//DFS
let dfsVertices = graph.depthFirstSearch(from: a)
dfsVertices.forEach { vertex in
    print(vertex)
}

//BFS
let bfsVertices = graph.breadthFirstSearch(from: a)
bfsVertices.forEach { vertex in
  print(vertex)
}

