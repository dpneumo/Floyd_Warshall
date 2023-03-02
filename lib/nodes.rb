class Nodes
  # structured_data: (Hash) {vname => nbrs, vname => nbrs, ..}
  # vname: (String) node name as human readable string
  # nbrs:  (Array) [nbr_info, nbr_info, ..]
  # nbr_info: (Array) [nbr vname, edge_dist]

  def initialize(structured_data)
    @structured_data = structured_data
  end

  def call
    @nodes ||= build_nodes
  end

  def build_nodes
    ndx = 0
    @structured_data.reduce([]) do |nodes, (k, v)|
      n = Node.new(ndx: ndx, vname: k, nbrs: v[:nbrs])
      ndx += 1
      nodes << n
      nodes
    end
  end

  def node_at(ndx)
    nodes[ndx].vname
  end

  def ndx_of(vname)
    nodes.each_index.select {|i| nodes[i].vname == vname }.first
  end
end
