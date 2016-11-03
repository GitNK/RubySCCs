require_relative "../KosarajusSCC"
require 'rspec'

describe KosarajusSCC do
	subject {KosarajusSCC}

	graph = Graph.new

	it "has accessor for solving SCC" do
		is_expected.to respond_to(:findSCCs).with(1).argument
	end

	it "SCC of empty graph should be 0" do
		expect(KosarajusSCC.findSCCs(graph).length).to eq(0)
	end

	it "should correctly compute SCC to equal 3" do 
		graph.add_edge(Edge.new(Vertex.new(7), Vertex.new(1)))
		graph.add_edge(Edge.new(Vertex.new(1), Vertex.new(4)))
		graph.add_edge(Edge.new(Vertex.new(4), Vertex.new(7)))
		graph.add_edge(Edge.new(Vertex.new(9), Vertex.new(7)))
		graph.add_edge(Edge.new(Vertex.new(6), Vertex.new(9)))
		graph.add_edge(Edge.new(Vertex.new(3), Vertex.new(6)))
		graph.add_edge(Edge.new(Vertex.new(9), Vertex.new(3)))
		graph.add_edge(Edge.new(Vertex.new(8), Vertex.new(6)))
		graph.add_edge(Edge.new(Vertex.new(2), Vertex.new(8)))
		graph.add_edge(Edge.new(Vertex.new(5), Vertex.new(2)))
		graph.add_edge(Edge.new(Vertex.new(8), Vertex.new(5)))
		expect(graph.vertex_count).to eq(9)
		expect(KosarajusSCC.findSCCs(graph).length).to eq(3)
	end

end