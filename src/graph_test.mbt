test "graph creation and node/edge addition" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  
  assert_eq(g.node_count(), 3)
  assert_true(g.node_weight(n0) == Some("A"))
  
  let e0 = g.add_edge(n0, n1, 10)
  let _ = g.add_edge(n1, n2, 20)
  
  assert_eq(g.edge_count(), 2)
  assert_true(g.edge_weight(e0) == Some(10))
  
  let nbrs = g.neighbors(n1)
  assert_eq(nbrs.length(), 1)
  assert_eq(nbrs[0].val, n2.val)
}

test "bfs and dfs traversal" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  let n3 = g.add_node("D")
  
  let _ = g.add_edge(n0, n1, 1)
  let _ = g.add_edge(n0, n2, 1)
  let _ = g.add_edge(n1, n3, 1)
  
  let bfs_res = g.bfs(n0)
  assert_eq(bfs_res.length(), 4)
  assert_eq(bfs_res[0].val, n0.val)
  assert_eq(bfs_res[1].val, n2.val)
  assert_eq(bfs_res[2].val, n1.val)
  assert_eq(bfs_res[3].val, n3.val)

  let dfs_res = g.dfs(n0)
  assert_eq(dfs_res.length(), 4)
  assert_eq(dfs_res[0].val, n0.val)
}

test "dijkstra shortest path" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  let n3 = g.add_node("D")
  
  let _ = g.add_edge(n0, n1, 1)
  let _ = g.add_edge(n0, n2, 4)
  let _ = g.add_edge(n1, n2, 2)
  let _ = g.add_edge(n1, n3, 6)
  let _ = g.add_edge(n2, n3, 3)
  
  let dists = g.dijkstra(n0)
  assert_eq(dists[n0.val], 0)
  assert_eq(dists[n1.val], 1)
  assert_eq(dists[n2.val], 3) // A -> B -> C = 1 + 2 = 3 (better than A -> C = 4)
  assert_eq(dists[n3.val], 6) // A -> B -> C -> D = 1 + 2 + 3 = 6
}

test "a_star pathfinding" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  let n3 = g.add_node("D")
  
  let _ = g.add_edge(n0, n1, 2)
  let _ = g.add_edge(n1, n3, 5)
  let _ = g.add_edge(n0, n2, 1)
  let _ = g.add_edge(n2, n3, 3)
  
  // Heuristic: estimated cost to D
  let heuristic = fn(node: NodeIndex) -> Int {
    if node.val == n0.val { 4 }
    else if node.val == n1.val { 3 }
    else if node.val == n2.val { 2 }
    else { 0 }
  }
  
  let path_opt = g.a_star(n0, n3, heuristic)
  assert_true(path_opt is Some(_))
  let path = path_opt.unwrap()
  assert_eq(path.length(), 3)
  assert_eq(path[0].val, n0.val)
  assert_eq(path[1].val, n2.val)
  assert_eq(path[2].val, n3.val)
}

test "bellman_ford negative weights" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  
  let _ = g.add_edge(n0, n1, 4)
  let _ = g.add_edge(n0, n2, 5)
  let _ = g.add_edge(n2, n1, -2) // Negative edge weight
  
  let res = g.bellman_ford(n0)
  assert_true(res is Ok(_))
  let dists = res.unwrap()
  assert_eq(dists[n0.val], 0)
  assert_eq(dists[n2.val], 5)
  assert_eq(dists[n1.val], 3) // A -> C -> B = 5 - 2 = 3
  
  // Add negative cycle
  let _ = g.add_edge(n1, n2, -1) // Cycle C -> B -> C weight is -2 + -1 = -3
  let res_cycle = g.bellman_ford(n0)
  assert_true(res_cycle is Err(_))
}

test "kruskal minimum spanning tree" {
  let g: Graph[String, Int] = Graph::new(directed=false)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  
  let _ = g.add_edge(n0, n1, 10)
  let _ = g.add_edge(n1, n2, 5)
  let _ = g.add_edge(n0, n2, 15)
  
  let mst = g.kruskal_mst()
  assert_eq(mst.length(), 2) // For 3 nodes, MST has 2 edges
}

test "topological sort" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  
  let _ = g.add_edge(n0, n1, 1)
  let _ = g.add_edge(n1, n2, 1)
  
  let sort_opt = g.topological_sort()
  assert_true(sort_opt is Some(_))
  let sorted = sort_opt.unwrap()
  assert_eq(sorted[0].val, n0.val)
  assert_eq(sorted[1].val, n1.val)
  assert_eq(sorted[2].val, n2.val)
  
  // Add a cycle to make topological sort fail
  let _ = g.add_edge(n2, n0, 1)
  let sort_cycle = g.topological_sort()
  assert_true(sort_cycle is None)
}

test "tarjan strongly connected components" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  let n3 = g.add_node("D")
  
  let _ = g.add_edge(n0, n1, 1)
  let _ = g.add_edge(n1, n2, 1)
  let _ = g.add_edge(n2, n0, 1) // SCC: {A, B, C}
  let _ = g.add_edge(n2, n3, 1) // D is outside
  
  let sccs = g.tarjan_scc()
  assert_eq(sccs.length(), 2)
}

test "cycle detection" {
  let gd: Graph[String, Int] = Graph::new(directed=true)
  let n0 = gd.add_node("A")
  let n1 = gd.add_node("B")
  let _ = gd.add_edge(n0, n1, 1)
  assert_eq(gd.has_cycle(), false)
  
  let _ = gd.add_edge(n1, n0, 1)
  assert_eq(gd.has_cycle(), true)

  let gu: Graph[String, Int] = Graph::new(directed=false)
  let u0 = gu.add_node("A")
  let u1 = gu.add_node("B")
  let u2 = gu.add_node("C")
  let _ = gu.add_edge(u0, u1, 1)
  let _ = gu.add_edge(u1, u2, 1)
  assert_eq(gu.has_cycle(), false)
  
  let _ = gu.add_edge(u2, u0, 1)
  assert_eq(gu.has_cycle(), true)
}

test "export graphviz dot" {
  let g: Graph[String, Int] = Graph::new(directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let _ = g.add_edge(n0, n1, 10)
  
  let dot = g.to_dot(fn(n) { n }, fn(e) { e.to_string() })
  assert_eq(dot.contains("digraph G"), true)
  assert_eq(dot.contains("0 -> 1"), true)
}
