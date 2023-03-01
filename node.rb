class Node
  include Comparable

  # ndx: (Integer) index of the node in the nodes array
  # vname: (String) human readable name
  # nbrs: (Array) neighbor info:
  #   (String) neighbor vname
  #   (Integer) edge distance between current node and neighbor

  attr_reader :ndx, :vname, :nbrs
  def initialize(ndx:, vname:, nbrs:)
    @ndx = ndx
    @vname = vname
    @nbrs = nbrs
  end

  # Provide this if sorting/comparisons are planned
  def <=>(other)
    other.some_property <=> @some_property
  end
end
