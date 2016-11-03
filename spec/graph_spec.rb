require_relative "../Graph"
require 'rspec'

# Graph Tests

describe Graph do
	subject(:graph) { Graph.new}

	it "has accessor for edge_count" do 
		is_expected.to respond_to(:edge_count)
	end

	it "has accesor for vertex_count" do
		is_expected.to respond_to(:vertex_count)
	end

	it "has accesor for add_edge with 1 argument" do
		is_expected.to respond_to(:add_edge).with(1).argument
	end

	it "has accesor for add_vertex with 1 argument" do
		is_expected.to respond_to(:add_vertex).with(1).argument
	end

	it "has accessor for get_vertex_by_name argument" do
		is_expected.to respond_to(:get_vertex_by_name)
	end

	it "edge_count should have initial value 0" do
		expect(graph.edge_count).to eq(0)
	end

	it "vartex_count should have initial value 0" do
		expect(graph.edge_count).to eq(0)
	end

	context "add edge" do

		it "edge_count value is 1" do
			v1 = Vertex.new(1)
			v2 = Vertex.new(2)
			edge = Edge.new(v1,v2)
			expect(graph.add_edge(edge)).to be true
			expect(graph.edge_count).to eq(1)
			expect(graph.vertex_count).to eq(2)
		end

		it "edge_count value is 0 on non-Edge obj" do
			expect(graph.add_edge("non_edge_obj")).to be nil
			expect(graph.edge_count).to eq(0)
		end
	end

	context "add vertex" do

		it "vertex count should update after adding new vertex" do
			graph.add_vertex(Vertex.new(1))
			graph.add_vertex(Vertex.new(3))
			graph.add_vertex(Vertex.new('1'))
			expect(graph.add_vertex(Vertex.new(1))).to be false
			expect(graph.vertex_count).to eq(3)
		end
	end

	context "get_vertex_by_name" do

		it "should return existing vertex" do
			vertex1 = Vertex.new(1)
			vertex2 = Vertex.new(2)
			vertexNaN = Vertex.new('NaN')
			expect(graph.add_vertex(vertex1)).to be true
			expect(graph.add_vertex(vertex2)).to be true

			got1 = graph.get_vertex_by_name(1)
			got2 = graph.get_vertex_by_name(2)
			gotNaN = graph.get_vertex_by_name('NaN')

			expect(got1).to eq(got1)
			expect(got2).to eq(got2)
			expect(gotNaN).to be nil
		end
	end
end

# Edge Tests

describe Edge do
	subject(:edge) {Edge.new(Vertex.new(1),Vertex.new(2))}

	it "has accessor for first_vertex" do
		is_expected.to respond_to(:first_vertex)
	end

	it "has accessor for second_vertex" do 
		is_expected.to respond_to(:second_vertex)
	end

	it "first_vertex.name value is 1" do
		expect(edge.first_vertex.name).to eq(1)
	end

	it "second_vertex.name value is 2" do
		expect(edge.second_vertex.name).to eq(2)
	end

	it "Should equal to same edge (1,2)" do
		expect(edge).to eq(Edge.new(Vertex.new(1),Vertex.new(2)))
	end
	it "Same edge with lower weight should be smaller" do
		newEdge = Edge.new(Vertex.new(1),Vertex.new(2), -10)
		expect(edge > newEdge).to be true
	end
end

# Vertex Tests

describe Vertex do 
	subject(:vertex) {Vertex.new(1)}

	it "has accessor for name" do
		is_expected.to respond_to(:name)
	end

	it "has accessor for outgoing edges" do 
		is_expected.to respond_to(:outgoing_edges)
	end

	it "has accessor for incoming edges" do 
		is_expected.to respond_to(:incoming_edges)
	end

	it "has accessor for explored" do 
		is_expected.to respond_to(:explored)
	end

	it "has accessor for second_order" do 
		is_expected.to respond_to(:second_order)
	end

	it "has accessor for leader" do
		is_expected.to respond_to(:leader)
	end

	it "second_order should be prioritized if not nil" do
		vtx1 = Vertex.new(1)
		vtx2 = Vertex.new(2)
		vtx1.second_order = 2
		vtx2.second_order = 1
		expect(vtx1 > vtx2).to be true
	end

	it "out/in edges count should be 0" do
		expect(vertex.outgoing_edges.count).to eq(0)
		expect(vertex.incoming_edges.count).to eq(0)
	end

	it "name equal to 1" do
		expect(vertex.name).to eq(1)
	end

	it "should equal to vertex with same name (1)" do
		sameNameV = Vertex.new(1)
		expect(vertex).to eq(sameNameV)
	end

	it "should have outgoing and incoming edge after edge creation" do
		secondVertex = Vertex.new(2)
		edge = Edge.new(vertex, secondVertex)
		expect(vertex.outgoing_edges.include?(edge)).to be true
		expect(secondVertex.incoming_edges.include?(edge)).to be true
		expect(vertex.outgoing_edges.count).to eq(1)
		expect(secondVertex.incoming_edges.count).to eq(1)
	end
end