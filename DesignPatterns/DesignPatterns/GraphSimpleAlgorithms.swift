//
//  GraphSimpleAlgorithms.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

// Graph representation (directional graph)

class Graph {
    private var adjancencyList: [[Int]]

    public var nodesCount: Int {
        return adjancencyList.count
    }

    init(nodesCount: Int) {
        adjancencyList = [[Int]]()
        guard nodesCount > 0 else {
            return
        }
        for _ in 1...nodesCount {
            adjancencyList.append([Int]())
        }
    }

    func addEdge(fromSource source: Int, toDestination destination: Int) -> Bool {
        guard
            source >= 0,
            source < nodesCount
        else {
            return false
        }
        var verticesList = adjancencyList[source]
        if verticesList.contains(destination) {
            return false
        }
        verticesList.append(destination)
        adjancencyList[source] = verticesList
        return true
    }

    func removeEdge(fromSource source: Int, toDestination destination: Int) -> Bool {
        guard
            source >= 0,
            source < nodesCount
        else {
            return false
        }
        var verticesList = adjancencyList[source]
        guard let index = verticesList.index(of: destination) else {
            return false
        }
        verticesList.remove(at: index)
        adjancencyList[source] = verticesList
        return true
    }

    func edges(fromSource source: Int) -> [Int] {
        guard
            source >= 0,
            source < nodesCount
        else {
            return [Int]()
        }
        return adjancencyList[source]
    }
}

// DFS traversal from a node

class DFSGraphTraversal {
    private let graph: Graph
    private var visited: Set<Int>

    init(graph: Graph) {
        self.graph = graph
        self.visited = Set<Int>()
    }

    func traverse(fromNode node: Int, withCallback callback: (Int) -> Void) {
        self.visited = Set<Int>()
        privateTraverse(fromNode: node, withCallback: callback)
    }

    private func privateTraverse(fromNode node: Int, withCallback callback: (Int) -> Void) {
        callback(node)
        visited.insert(node)
        for destinationNode in graph.edges(fromSource: node) {
            guard !visited.contains(destinationNode) else {
                continue
            }
            privateTraverse(fromNode: destinationNode, withCallback: callback)
        }
    }
}

// BFS traversal from a node

class BFSGraphTraversal {
    private let graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    func traverse(fromNode node: Int, withCallback callback: (Int) -> Void) {
        var visited = Set<Int>()
        var queue = [Int]()
        queue.append(node)
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            callback(currentNode)
            visited.insert(currentNode)
            for destinationNode in graph.edges(fromSource: currentNode) {
                guard !visited.contains(destinationNode) else {
                    continue
                }
                queue.append(destinationNode)
            }
        }
    }
}

class TopologicalSort {
    private let graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    private func inDegree(forSource source: Int) -> Int {
        var result = 0
        for i in 0..<graph.nodesCount {
            if graph.edges(fromSource: i).contains(source) {
                result = result + 1
            }
        }
        return result
    }

    func sort(withCallback callback: (Int) -> Void) {
        var visited = Set<Int>()
        while visited.count < graph.nodesCount {
            for i in 0..<graph.nodesCount {
                if
                    inDegree(forSource: i) == 0,
                    !visited.contains(i)
                {
                    visited.insert(i)
                    callback(i)
                }
                for destinationNode in graph.edges(fromSource: i) {
                    _ = graph.removeEdge(fromSource: i, toDestination: destinationNode)
                }
            }
        }
    }
}
