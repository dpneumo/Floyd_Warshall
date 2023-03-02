class Parser
  def initialize(test: true)
    data_extension = test ? "_test" : ""
    @valve_data = "#{File.dirname(__FILE__)}/valves#{data_extension}.txt"
    @edgedist = 1
  end

  def structured_data
    parse_file.reduce({}) do |valves, (vname, flow, nbrs)|
      nbrs = nbrs.split(', ').map{|vname| [vname, @edgedist] }
      valves[vname] = { flow: flow, nbrs: nbrs }
      valves
    end
  end

  def show_data
    puts "Structured Data:"
    keys = structured_data.keys
    keys.each {|k| puts "node #{k}: #{structured_data[k]}" }
  end

private
  def parse_file
    r = Regexp.new( '\AValve (\w\w) .+rate=(\d+).*valves? (.*)\z' )
    File.foreach(@valve_data).map do |line|
      line.chomp
      .match(r) {|md| [md[1], md[2].to_i, md[3]] }
    end
  end
end
