# MoonGraph

MoonGraph is a high-performance, general-purpose graph data structure and algorithm library implemented purely in the MoonBit programming language. It is designed to be the foundational building block for complex network analysis, pathfinding, dependency resolution, and compiler infrastructure.

## Features

*   **Core Data Structures**: Adjacency list based `Graph[N, E]` supporting both Directed and Undirected graphs with generic node/edge weights.
*   **Graph Traversal**: Highly efficient Breadth-First Search (BFS) and Depth-First Search (DFS) algorithms.
*   **Shortest Path & Pathfinding**:
    *   **Dijkstra's Algorithm**: For finding single-source shortest paths in weighted graphs (non-negative weights).
    *   **A* (A-Star) Pathfinding**: Heuristic-based shortest path search.
    *   **Bellman-Ford Algorithm**: Handles negative edge weights and detects negative cycles.
*   **Minimum Spanning Tree (MST)**: Kruskal's algorithm backed by a robust Disjoint Set (Union-Find) structure.
*   **Advanced Algorithms**:
    *   **Topological Sort**: Kahn's algorithm for directed acyclic graphs (DAGs).
    *   **Tarjan's SCC**: Finding Strongly Connected Components (SCC) in directed graphs.
    *   **Cycle Detection**: Detects cycles in both directed and undirected graphs.
*   **Visualization**:
    *   **Graphviz DOT Exporter**: Exports the graph structure to Graphviz DOT string representation.
*   **Zero Dependencies**: Pure MoonBit implementation with no external package dependencies.

## Usage

### Basic Graph Creation & Traversal
```moonbit
let g: Graph[String, Int] = Graph::new(directed=true)
let a = g.add_node("A")
let b = g.add_node("B")
let c = g.add_node("C")
g.add_edge(a, b, 10)
g.add_edge(b, c, 15)

// Traversals
let bfs_result = g.bfs(a)
let dfs_result = g.dfs(a)
```

### Dijkstra & A* Pathfinding
```moonbit
// Dijkstra's algorithm
let distances = g.dijkstra(a)

// A* pathfinding (with heuristic)
let heuristic = fn(node) { 0 }
let path = g.a_star(a, c, heuristic)
```

### Tarjan's SCC & Topological Sort
```moonbit
// Find Strongly Connected Components
let sccs = g.tarjan_scc()

// Get Topological Order
let sorted = g.topological_sort()
```

### Exporter (Graphviz DOT)
```moonbit
let dot_string = g.to_dot(
  fn(node_weight) { node_weight }, 
  fn(edge_weight) { edge_weight.to_string() }
)
```

## Future Roadmap

- Floyd-Warshall Algorithm (All-pairs shortest paths)
- Maximum Flow / Minimum Cut (Ford-Fulkerson)
- Graph isomorphism detection

## License

MIT License
