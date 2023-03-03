class FloydWarshall
  # node attr: :ndx, :vname, :nbrs
  # @dist matrix: minimum distance between any 2 nodes
  # @nxt matrix: to reconstruct min distance path between any 2 nodes

  def initialize(nodes:)
    @nodes = nodes
  end

  def fwa
    fwa_setup
    nsize.times do |k|  #via
      nsize.times do |i|  #from
        nsize.times do |j|  #to
          if @dist[i][j] > @dist[i][k] + @dist[k][j]
            @dist[i][j] = @dist[i][k] + @dist[k][j]
          end
        end
      end
    end
    @dist
  end

  def fwa_trace
    fwa_setup
    nsize.times do |k|
      nsize.times do |i|
        nsize.times do |j|
          if @dist[i][j] > @dist[i][k] + @dist[k][j]
            @dist[i][j] = @dist[i][k] + @dist[k][j]
            @nxt[i][j]  = @nxt[i][k]
          end
        end
      end
    end
    @dist
  end

  def fwa_undirected
    fwa_setup
    nsize.times do |k|  #via
      nsize.times do |i|  #from
        i.times do |j|  #to
          if @dist[i][j] > @dist[i][k] + @dist[k][j]
            @dist[i][j] = @dist[j][i] = @dist[i][k] + @dist[k][j]
          end
        end
      end
    end
    @dist
  end

  def fwa_ut
    fwa_setup
    nsize.times do |k|
      nsize.times do |i|
        i.times do |j|
          if @dist[i][j] > @dist[i][k] + @dist[k][j]
            @dist[i][j] = @dist[j][i] = @dist[i][k] + @dist[k][j]
            @nxt[i][j]  = @nxt[j][i]  = @nxt[i][k]
          end
        end
      end
    end
    @dist
  end

  def path(u, v)
    return [] if @nxt[u][v] == nil
    path = [u]
    while u != v
      u = @nxt[u][v]
      path << u
    end
    path
  end

private
  def fwa_setup
    @nxt  = init_2d_arry(size: nsize, initval: nil)
    @dist = init_2d_arry(size: nsize, initval: Float::INFINITY)
    @nodes.each do |n|
      u = n.ndx
      n.nbrs.each do |nbrinfo|
        v = @nodes.find {|n| n.vname == nbrinfo[0] }.ndx
        @dist[u][v] = nbrinfo[1]
        @nxt[u][v] = v
      end
    end
    nsize.times do |v|
      @dist[v][v] = 0
      @nxt[v][v]  = v
    end
  end

  def nsize; @nsize ||= @nodes.size; end

  def init_2d_arry(size:,initval:)
    size.times.reduce([]) do |rows,_|
      rows << size.times.reduce([]) do |cols,_|
        cols << initval; cols
      end; rows
    end
  end
end

