pub struct NodeIndex {
  val : Int
} derive(Eq, Compare, Show)

pub struct EdgeIndex {
  val : Int
} derive(Eq, Compare, Show)

struct NodeData[N] {
  weight : N
  mut first_outgoing_edge : EdgeIndex?
}

struct EdgeData[E] {
  weight : E
  target_node : NodeIndex
  next_outgoing_edge : EdgeIndex?
}

/// A graph data structure using adjacency list.
pub struct Graph[N, E] {
  nodes : Array[NodeData[N]]
  edges : Array[EdgeData[E]]
  is_directed : Bool
}

/// Creates a new empty graph.
pub fn Graph::new[N, E](~directed : Bool = true) -> Graph[N, E] {
  { nodes: [], edges: [], is_directed: directed }
}

/// Adds a node with the given weight to the graph.
pub fn add_node[N, E](self : Graph[N, E], weight : N) -> NodeIndex {
  let idx = self.nodes.length()
  self.nodes.push({ weight, first_outgoing_edge: None })
  { val: idx }
}

/// Adds an edge from `source` to `target` with the given `weight`.
pub fn add_edge[N, E](self : Graph[N, E], source : NodeIndex, target : NodeIndex, weight : E) -> EdgeIndex {
  let s = source.val
  let edge_idx = self.edges.length()
  let prev_first = self.nodes[s].first_outgoing_edge
  self.edges.push({ weight, target_node: target, next_outgoing_edge: prev_first })
  self.nodes[s].first_outgoing_edge = Some({ val: edge_idx })

  if not(self.is_directed) {
    let t = target.val
    let rev_edge_idx = self.edges.length()
    let t_prev_first = self.nodes[t].first_outgoing_edge
    // NOTE: For undirected graphs, we duplicate the edge in the reverse direction.
    // In a real optimized library, we might share edge data or use different indexing,
    // but this is standard for adjacency lists.
    self.edges.push({ weight, target_node: source, next_outgoing_edge: t_prev_first })
    self.nodes[t].first_outgoing_edge = Some({ val: rev_edge_idx })
  }

  { val: edge_idx }
}
