//
//  GraphAlgorithmsTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class GraphAlgorithmsTests : XCTestCase {

    // MARK :- Simple graph algorithms

    func testSimpleGraphOperations() {
        let graph = createSimpleGraph()
        XCTAssertFalse(graph.removeEdge(fromSource: 0, toDestination: 3))
        XCTAssertTrue(graph.addEdge(fromSource: 3, toDestination: 2))
        XCTAssertEqual(graph.edges(fromSource: 0), [1, 4])
        XCTAssertEqual(graph.edges(fromSource: 1), [2])
        XCTAssertEqual(graph.edges(fromSource: 2), [0])
        XCTAssertEqual(graph.edges(fromSource: 3), [1, 2])
        XCTAssertEqual(graph.edges(fromSource: 4), [3])
    }

    func testDFSTraversal() {
        let graph = createSimpleGraph()
        let dfsTraversal = DFSGraphTraversal(graph: graph)
        var visitedNodes = [Int]()
        dfsTraversal.traverse(fromNode: 0, withCallback: {
            visitedNodes.append($0)
        })
        XCTAssertEqual(visitedNodes, [0, 1, 2, 4, 3])
    }

    func testBFSTraversal() {
        let graph = createSimpleGraph()
        let bfsTraversal = BFSGraphTraversal(graph: graph)
        var visitedNodes = [Int]()
        bfsTraversal.traverse(fromNode: 0, withCallback: {
            visitedNodes.append($0)
        })
        XCTAssertEqual(visitedNodes, [0, 1, 4, 2, 3])
    }

    func testTopological() {
        let graph = createSimpleGraph()
        XCTAssertTrue(graph.removeEdge(fromSource: 2, toDestination: 0))
        let bfsTraversal = TopologicalSort(graph: graph)
        var visitedNodes = [Int]()
        bfsTraversal.sort(withCallback: {
            visitedNodes.append($0)
        })
        XCTAssertEqual(visitedNodes, [0, 2, 4, 1, 3])
    }

    // MARK :- Weighted graph algorithms

    func testDijkstra() {
        let graph = createWeightedGraph()
        let dijkstra = Dijkstra(graph: graph)
        XCTAssertEqual(dijkstra.minimumWeights(fromSource: 0), [0, 5, 6, 20, Double.infinity])
    }

    func testKruskal() {
        let graph = createWeightedGraph()
        let kruskal = Kruskal(graph: graph)
        let expectedMST = [(source: 1, destination: 2), (source: 3, destination: 1), (source: 0, destination: 1), (source: 4, destination: 3)]
        let mst = kruskal.minimumSpanningTree()
        for (lhs, rhs) in zip(mst, expectedMST) {
            XCTAssertEqual(lhs.source, rhs.source)
            XCTAssertEqual(lhs.destination, rhs.destination)
        }
    }

    // MARK :- Private helpers

    private func createSimpleGraph() -> Graph {
        let graph = Graph(nodesCount: 5)

        XCTAssert(graph.addEdge(fromSource: 0, toDestination: 1))
        XCTAssert(graph.addEdge(fromSource: 1, toDestination: 2))
        XCTAssert(graph.addEdge(fromSource: 2, toDestination: 0))
        XCTAssert(graph.addEdge(fromSource: 0, toDestination: 4))
        XCTAssert(graph.addEdge(fromSource: 4, toDestination: 3))
        XCTAssert(graph.addEdge(fromSource: 3, toDestination: 1))

        return graph
    }

    private func createWeightedGraph() -> GraphWithWeightedEdges {
        let graph = GraphWithWeightedEdges(nodesCount: 5)

        XCTAssert(graph.addEdge(fromSource: 0, toDestination: 1, withCost: 5))
        XCTAssert(graph.addEdge(fromSource: 1, toDestination: 2, withCost: 1))
        XCTAssert(graph.addEdge(fromSource: 2, toDestination: 0, withCost: 7))
        XCTAssert(graph.addEdge(fromSource: 0, toDestination: 2, withCost: 9))
        XCTAssert(graph.addEdge(fromSource: 4, toDestination: 3, withCost: 8))
        XCTAssert(graph.addEdge(fromSource: 3, toDestination: 1, withCost: 1))
        XCTAssert(graph.addEdge(fromSource: 1, toDestination: 3, withCost: 15))

        return graph
    }
}
