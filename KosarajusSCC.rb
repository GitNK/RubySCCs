require_relative "Graph"

class KosarajusSCC
	@@SCCc
	@@t
	@@s

	def self.findSCCs(graph)
		raise ArgumentError, 'Argument is not Graph' unless graph.is_a? Graph 
		@@SCCc = Hash.new(0)
		puts "DFS_Loop_1" 
		self.DFS_Loop_1(graph)
		# reset explored
		graph.verticies.each {|v| v.explored = false}
		puts "DFS_Loop_2"
		self.DFS_Loop_2(graph)
		@@SCCc
	end

	def self.DFS_Loop_1(graph)
		@@t = 0 # global variable for finishing time
		count = graph.verticies.count
		count.downto(1) do |i|
			i_vertex = graph.get_vertex_by_name(i)
			if !i_vertex.explored
				self.RevDFS(graph, i_vertex)
			end
		end
	end

	def self.DFS_Loop_2(graph)
		@@s = nil # global variable for leaders
		graph.verticies.sort.reverse.each do |v|
			if v.explored == false
				@@s = v
				self.DFS(graph, v)
			end
		end
	end

	def self.DFS(graph, v)

		verticies_to_process = [v]
		idx = 0
		count = verticies_to_process.count
		while idx < count
			made_insert = false
			currentVertex = verticies_to_process[idx]
			currentVertex.explored = true
			outgoing_edges = currentVertex.outgoing_edges
			
			outgoing_edges.each do |out_edge|
				if !out_edge.second_vertex.explored
					verticies_to_process.insert(idx, out_edge.second_vertex)
					count += 1
					made_insert = true
					break
				end
			end
			if !made_insert
				idx += 1
				currentVertex.leader = @@s
				@@SCCc[@@s.name] += 1
			end
		end
	end


	def self.RevDFS(graph, v) 
		verticies_to_process = [v]
		idx = 0
		count = verticies_to_process.count
		while idx < count

			made_insert = false

			currentVertex = verticies_to_process[idx]
			currentVertex.explored = true
			incoming_edges = currentVertex.incoming_edges

			incoming_edges.each do |rev_edge|
				if !rev_edge.first_vertex.explored
					verticies_to_process.insert(idx, rev_edge.first_vertex) # prepend
					count += 1
					made_insert = true
					break
				end
			end
			if !made_insert
				@@t += 1
				currentVertex.second_order = @@t
				idx += 1
			end
		end
	end
end