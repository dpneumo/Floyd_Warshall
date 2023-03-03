require_relative 'requires'
class Runner
  Test = true

  def initialize( parser: Parser, nodes: Nodes,
                  floyd_warshall: FloydWarshall )
    @parser = parser.new(test: Test)
    structured_data = @parser.structured_data
    @nodes = nodes.new(structured_data).call
    @floyd_warshall = floyd_warshall.new(nodes: @nodes)
  end

  def run
    @parser.show_data

    cm =  @floyd_warshall.fwa_trace
    puts "\nCost Matrix:"
    cm.each {|row| puts "#{row }" }

    path = @floyd_warshall.path(9,7)
    puts "\nShortest path from #{@nodes[9].vname} to #{@nodes[7].vname}:"
    puts path.map {|ndx| @nodes[ndx].vname }.join(' -> ')
  end
end

Runner.new.run
