//
//  GraphCostAlgorithms.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 7/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class GraphWithWeightedEdges {
    private var matrix: [[Double]]

    public var nodesCount: Int {
        return matrix.count
    }

    init(nodesCount: Int) {
        matrix = [[Double]]()
        guard nodesCount > 0 else {
            return
        }
        for _ in 1...nodesCount {
            var line = [Double]()
            for _ in 1...nodesCount {
                line.append(Double.infinity)
            }
            matrix.append(line)
        }
    }

    func addEdge(fromSource source: Int, toDestination destination: Int, withCost cost: Double) -> Bool {
        guard
            source >= 0,
            source < nodesCount,
            destination >= 0,
            destination < nodesCount
        else {
            return false
        }
        var line = matrix[source]
        line[destination] = cost
        matrix[source] = line
        return true
    }

    func removeEdge(fromSource source: Int, toDestination destination: Int) -> Bool {
        return addEdge(fromSource: source, toDestination: destination, withCost: Double.infinity)
    }

    func cost(fromSource source: Int, toDestination destination: Int) -> Double {
        guard
            source >= 0,
            source < nodesCount,
            destination >= 0,
            destination < nodesCount
        else {
            return Double.infinity
        }
        return matrix[source][destination]
    }
}

class Dijkstra {
    let graph: GraphWithWeightedEdges

    init(graph: GraphWithWeightedEdges) {
        self.graph = graph
    }

    func minimumWeights(fromSource source: Int) -> [Double] {
        var result = [Double]()
        for _ in 1...graph.nodesCount {
            result.append(Double.infinity)
        }
        result[source] = 0
        var visited = Set<Int>()
        while true {
            var minIndexOptional: Int?
            var minWeight = Double.infinity
            for i in 0..<graph.nodesCount {
                guard !visited.contains(i) else {
                    continue
                }
                if minWeight > result[i] {
                    minWeight = result[i]
                    minIndexOptional = i
                }
            }

            guard
                let minIndex = minIndexOptional
            else {
                break
            }

            visited.insert(minIndex)

            let node = minIndex
            for i in 0..<graph.nodesCount {
                let cost = graph.cost(fromSource: node, toDestination: i)
                if
                    !visited.contains(i),
                    cost != Double.infinity
                {
                    if result[i] > result[node] + cost {
                        result[i] = result[node] + cost
                    }
                }
            }
        }
        return result
    }
}

// Kruskal - minimum spanning tree algorithm

class Kruskal {
    private let graph: GraphWithWeightedEdges
    private var parents: [Int]

    init(graph: GraphWithWeightedEdges) {
        self.graph = graph
        self.parents = [Int]()
        for _ in 0..<graph.nodesCount {
            parents.append(-1)
        }
    }

    private func findParent(ofNode node: Int) -> Int {
        if parents[node] == -1 {
            return node
        }
        return findParent(ofNode: parents[node])
    }

    private func isCycle(forEdges edges: [(source: Int, destination: Int)]) -> Bool {
        self.parents = [Int]()
        for _ in 0..<graph.nodesCount {
            parents.append(-1)
        }
        for edge in edges {
            let x = findParent(ofNode: edge.source)
            let y = findParent(ofNode: edge.destination)
            if x == y {
                return true
            }
            parents[x] = y
        }
        return false
    }

    // Return the MST as a list of edges in the original graph
    func minimumSpanningTree() -> [(source: Int, destination: Int)] {
        var result = [(source: Int, destination: Int)]()
        var edges = [(source: Int, destination: Int, cost: Double)]()
        for i in 0..<graph.nodesCount {
            for j in 0..<graph.nodesCount {
                guard i != j else {
                    continue
                }
                let cost = graph.cost(fromSource: i, toDestination: j)
                guard cost != Double.infinity else {
                    continue
                }
                edges.append((source: i, destination: j, cost: cost))
            }
        }

        edges.sort(by: { $0.cost < $1.cost } )

        for edge in edges {
            // Check if there is a cycle is we were to add `edge` to `result`
            var tmpEdges = result
            let tmpEdge = (source: edge.source, destination: edge.destination)
            tmpEdges.append(tmpEdge)
            if !isCycle(forEdges: tmpEdges) {
                result.append(tmpEdge)
            }
            if result.count == graph.nodesCount - 1 {
                break
            }
        }

        return result
    }
}
