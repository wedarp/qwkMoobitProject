test "graph creation and node/edge addition" {
  let g: Graph[String, Int] = Graph::new(~directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  
  assert_eq!(g.node_count(), 3)
  assert_eq!(g.node_weight(n0), Some("A"))
  
  let e0 = g.add_edge(n0, n1, 10)
  let e1 = g.add_edge(n1, n2, 20)
  
  assert_eq!(g.edge_count(), 2)
  assert_eq!(g.edge_weight(e0), Some(10))
  
  let nbrs = g.neighbors(n1)
  assert_eq!(nbrs.length(), 1)
  assert_eq!(nbrs[0].val, n2.val)
}

test "bfs traversal" {
  let g: Graph[String, Int] = Graph::new(~directed=true)
  let n0 = g.add_node("A")
  let n1 = g.add_node("B")
  let n2 = g.add_node("C")
  let n3 = g.add_node("D")
  
  let _ = g.add_edge(n0, n1, 1)
  let _ = g.add_edge(n0, n2, 1)
  let _ = g.add_edge(n1, n3, 1)
  
  let bfs_res = g.bfs(n0)
  assert_eq!(bfs_res.length(), 4)
  assert_eq!(bfs_res[0].val, n0.val)
  // BFS order depends on edge iteration order.
  // We pushed B then C, but neighbors might return them in reverse order because we prepend to the linked list.
  // The first outgoing edge of A will be C (because it was added last).
  // So neighbors of A -> [C, B].
  // Expected BFS: A, C, B, D.
  assert_eq!(bfs_res[1].val, n2.val)
  assert_eq!(bfs_res[2].val, n1.val)
  assert_eq!(bfs_res[3].val, n3.val)
}
