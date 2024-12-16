local day16 = require("day16_part1")

local function key(r, c, dr, dc)
	return string.format("%d,%d,%d,%d", r, c, dr, dc)
end

local function adjacency_matrix(map)
	local result = {}

	for r = 1, map.rows do
		for c = 1, map.cols do
			if map[r][c] == "#" then
				goto next
			end

			result[key(r, c, 1, 0)] = {}
			result[key(r, c, -1, 0)] = {}
			result[key(r, c, 0, 1)] = {}
			result[key(r, c, 0, -1)] = {}

			result[key(r, c, 1, 0)][key(r, c, 0, 1)] = 1000
			result[key(r, c, 1, 0)][key(r, c, 0, -1)] = 1000
			result[key(r, c, 1, 0)][key(r, c, -1, 0)] = 2000
			if map[r + 1][c] ~= "#" then
				result[key(r, c, 1, 0)][key(r + 1, c, 1, 0)] = 1
			end

			result[key(r, c, -1, 0)][key(r, c, 0, 1)] = 1000
			result[key(r, c, -1, 0)][key(r, c, 0, -1)] = 1000
			result[key(r, c, -1, 0)][key(r, c, 1, 0)] = 2000
			if map[r - 1][c] ~= "#" then
				result[key(r, c, -1, 0)][key(r - 1, c, -1, 0)] = 1
			end

			result[key(r, c, 0, 1)][key(r, c, 1, 0)] = 1000
			result[key(r, c, 0, 1)][key(r, c, -1, 0)] = 1000
			result[key(r, c, 0, 1)][key(r, c, 0, -1)] = 2000
			if map[r][c + 1] ~= "#" then
				result[key(r, c, 0, 1)][key(r, c + 1, 0, 1)] = 1
			end

			result[key(r, c, 0, -1)][key(r, c, 1, 0)] = 1000
			result[key(r, c, 0, -1)][key(r, c, -1, 0)] = 1000
			result[key(r, c, 0, -1)][key(r, c, 0, 1)] = 2000
			if map[r][c - 1] ~= "#" then
				result[key(r, c, 0, -1)][key(r, c - 1, 0, -1)] = 1
			end

			::next::
		end
	end

	return result
end

local function dijkstra(matrix, node)
	local results = { [node] = { score = 0, from = {} } }
	local visited = {}

	while true do
		local nodes = {}
		for n in pairs(results) do
			if not visited[n] then
				table.insert(nodes, n)
			end
		end
		if #nodes == 0 then
			break
		end

		table.sort(nodes, function(a, b)
			return results[a].score < results[b].score
		end)

		local this_node = nodes[1]
		local this_score = results[this_node].score

		visited[this_node] = true

		for next_node, next_score in pairs(matrix[this_node]) do
			local data = results[next_node]
			if data == nil then
				data = { score = this_score + next_score, from = { [this_node] = true } }
				results[next_node] = data
			else
				if this_score + next_score == data.score then
					data.from[this_node] = true
				elseif this_score + next_score < data.score then
					data.score = this_score + next_score
					data.from = { [this_node] = true }
				end
			end
		end
	end

	return results
end

local function run()
	local map, start_row, start_col, end_row, end_col = day16.read_input()
	local matrix = adjacency_matrix(map)
	local node = key(start_row, start_col, 0, 1)

	local results = dijkstra(matrix, node)

	local search = string.format("^%d,%d,", end_row, end_col)
	local min_score_end_nodes = {}
	for n, data in pairs(results) do
		if string.find(n, search) then
			table.insert(min_score_end_nodes, { n, data.score })
		end
	end
	table.sort(min_score_end_nodes, function(a, b)
		return a[2] < b[2]
	end)

	while min_score_end_nodes[#min_score_end_nodes][2] > min_score_end_nodes[1][2] do
		table.remove(min_score_end_nodes)
	end

	local next_nodes = {}
	for _, n in ipairs(min_score_end_nodes) do
		table.insert(next_nodes, n[1])
	end

	local tiles = {}
	local count = 0
	while #next_nodes > 0 do
		local n = table.remove(next_nodes)
		local _, _, nkey = string.find(n, "^(%d+,%d+),")
		if not tiles[nkey] then
			count = count + 1
			tiles[nkey] = true
		end

		for f in pairs(results[n].from) do
			table.insert(next_nodes, f)
		end
	end

	print(count)
end

run()
