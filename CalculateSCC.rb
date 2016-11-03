require_relative "KosarajusSCC"
require 'set'

def analyze_file()
	graph = Graph.new
	bla = Set.new
	File.foreach('_SCC.txt') do |line|
		line.chomp!
		nums = line.split.map { |e| e.to_i }
		raise ArgumentError, 'Error' unless nums.count == 2 
		graph.add_edge(Edge.new(Vertex.new(nums[0]), Vertex.new(nums[1])))
	end
	sccs = KosarajusSCC.findSCCs(graph)
	i = 1
	sccs.values.sort.reverse.each do |value|
		if i > 5
			break
		end
		puts value
		i += 1
	end
end

analyze_file