# MoonGraph

MoonGraph is a high-performance, general-purpose graph data structure and algorithm library implemented purely in the MoonBit programming language. It is designed to be the foundational building block for complex network analysis, pathfinding, dependency resolution, and compiler infrastructure.

## Features

*   **Core Data Structures**: Adjacency list based `Graph[N, E]` supporting both Directed and Undirected graphs with generic node/edge weights.
*   **Graph Traversal**: Highly efficient Breadth-First Search (BFS) and Depth-First Search (DFS) algorithms.
*   **Shortest Path**: Implementation of Dijkstra's algorithm for finding shortest paths in weighted graphs using a custom Min-Heap Priority Queue.
*   **Minimum Spanning Tree**: Kruskal's algorithm backed by a robust Disjoint Set (Union-Find) structure.
*   **Advanced Algorithms**: Topological Sort using Kahn's algorithm for DAGs (Directed Acyclic Graphs).
*   **Zero Dependencies**: Pure MoonBit implementation with no external package dependencies.

## Usage

```moonbit
let g: Graph[String, Int] = Graph::new(~directed=true)
let a = g.add_node("A")
let b = g.add_node("B")
g.add_edge(a, b, 10)

// Traversal
let bfs_result = g.bfs(a)

// Shortest Path
let distances = g.dijkstra(a)

// Topological Sort
let sorted = g.topological_sort()
```

## Future Roadmap

- A* Search Algorithm
- Bellman-Ford Algorithm (negative weights)
- Graphviz DOT format exporter
- Maximum Flow / Minimum Cut

## License

MIT License
