class Graph

	@edges
	@verticies
	@vertex_hash

	# init empty graph
	def initialize()
		@edges = []
		@verticies = []
		@vertex_hash = Hash.new
	end

	def edge_count
		@edges.count
	end

	def vertex_count
		@verticies.count
	end

	def verticies
		@verticies
	end

	def add_edge(edge)
		if not edge.is_a?(Edge)
			return nil
		end
		# if edge verticies/x is new -
		# create those verticies/x and add them/it
		# to @verticies array
		# if verticies are present - add this edge to
		# in-out degree verticies
		first_name = edge.first_vertex.name
		second_name = edge.second_vertex.name

		#first_index = @verticies.index(edge.first_vertex)
		#second_index = @verticies.index(edge.second_vertex)
		if !@vertex_hash.key?(first_name)
			@verticies << edge.first_vertex
			@vertex_hash[first_name] = edge.first_vertex
		else
			edge.first_vertex = @vertex_hash[first_name]
			@vertex_hash[first_name].outgoing_edges << edge
		end
		if !@vertex_hash.key?(second_name)
			@verticies << edge.second_vertex
			@vertex_hash[second_name] = edge.second_vertex
		else
			edge.second_vertex = @vertex_hash[second_name]
			@vertex_hash[second_name].incoming_edges << edge
		end
		@edges << edge
		true
	end

	def add_vertex(vertex)
		name = vertex.name
		if @vertex_hash.key?(name)
			return false
		end
		@verticies << vertex
		@vertex_hash[name] = vertex
		true
	end

	def get_vertex_by_name(name)
		if !@vertex_hash.key?(name)
			return nil
		end
		@vertex_hash[name]
	end
	
end

class Edge

	include Comparable

	attr_accessor :first_vertex, :second_vertex, :weight

	def <=>(anOther)
    if self.weight == anOther.weight && 
    	self.first_vertex.name == anOther.first_vertex.name &&
    	self.second_vertex.name == anOther.second_vertex.name
    	return 0
    else
    	return self.weight <=> anOther.weight	
    end
  end

	def initialize(first, second, weight = 0)
		raise ArgumentError, 'First argument is not Vertex' unless first.is_a? Vertex 
		raise ArgumentError, 'Second argument is not Vertex' unless second.is_a? Vertex 
		self.first_vertex = first
		self.second_vertex = second
		self.weight = weight
		self.first_vertex.outgoing_edges << self
		self.second_vertex.incoming_edges << self
	end
	
end

class Vertex

	include Comparable
	
	attr_accessor :name, :outgoing_edges, :incoming_edges, :explored, :second_order, :leader

	def <=>(anOther)
		if self.second_order == nil ||
		 anOther.second_order == nil
			return self.name <=> anOther.name
		end
		self.second_order <=> anOther.second_order
	end

	def initialize(vertex_name)
		self.name = vertex_name
		self.outgoing_edges = []
		self.incoming_edges = []
		self.explored = false
		self.second_order = nil
		self.leader = nil
	end

end
