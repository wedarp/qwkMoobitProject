pub fn[N, E] Graph::node_count(self : Graph[N, E]) -> Int {
  self.nodes.length()
}

pub fn[N, E] Graph::edge_count(self : Graph[N, E]) -> Int {
  self.edges.length()
}

pub fn[N, E] Graph::node_weight(self : Graph[N, E], idx : NodeIndex) -> N? {
  if idx.val >= 0 && idx.val < self.nodes.length() {
    Some(self.nodes[idx.val].weight)
  } else {
    None
  }
}

pub fn[N, E] Graph::edge_weight(self : Graph[N, E], idx : EdgeIndex) -> E? {
  if idx.val >= 0 && idx.val < self.edges.length() {
    Some(self.edges[idx.val].weight)
  } else {
    None
  }
}

pub fn[N, E] Graph::neighbors(self : Graph[N, E], source : NodeIndex) -> Array[NodeIndex] {
  let result = []
  if source.val < 0 || source.val >= self.nodes.length() {
    return result
  }
  let mut curr_edge = self.nodes[source.val].first_outgoing_edge
  while true {
    match curr_edge {
      None => break
      Some(edge_idx) => {
        let edge = self.edges[edge_idx.val]
        result.push(edge.target_node)
        curr_edge = edge.next_outgoing_edge
      }
    }
  }
  result
}

