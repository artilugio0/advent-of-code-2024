local function read_input()
	local bytes = {}
	local rows = 0
	local cols = 0
	for line in io.lines() do
		if line == "" then
			break
		end

		local _, e, c = string.find(line, "(%d+)")
		local _, _, r = string.find(line, "(%d+)", e + 1)
		r = tonumber(r)
		c = tonumber(c)

		if r ~= nil and r > rows then
			rows = r
		end
		if c ~= nil and c > cols then
			cols = c
		end

		table.insert(bytes, { r, c })
	end
	bytes.rows = rows + 1
	bytes.cols = cols + 1

	return bytes
end

local function bfs_exit(map, sr, sc, er, ec)
	local adj = function(r, c)
		local a = {}
		if map[r - 1] ~= nil and not map[r - 1][c] then
			table.insert(a, { r - 1, c })
		end
		if map[r + 1] ~= nil and not map[r + 1][c] then
			table.insert(a, { r + 1, c })
		end
		if map[r][c - 1] ~= nil and not map[r][c - 1] then
			table.insert(a, { r, c - 1 })
		end
		if map[r][c + 1] ~= nil and not map[r][c + 1] then
			table.insert(a, { r, c + 1 })
		end

		return a
	end

	local key = function(x)
		return string.format("%d,%d", x[1], x[2])
	end

	local pq = { { sr, sc } }
	local distances = { [key({ sr, sc })] = 0 }
	local seen = {}

	while #pq > 0 do
		local x = table.remove(pq, 1)
		if x[1] == er and x[2] == ec then
			break
		end

		local this_prio = distances[key(x)]

		for _, a in ipairs(adj(x[1], x[2])) do
			if not seen[key(a)] then
				seen[key(a)] = true
				distances[key(a)] = this_prio + 1
				table.insert(pq, a)
			end
		end
	end

	return distances[key({ er, ec })]
end

local function run()
	local bytes = read_input()

	local map = {}
	for r = 0, bytes.rows - 1 do
		map[r] = {}
		for c = 0, bytes.cols - 1 do
			map[r][c] = false
		end
	end
	map.rows = bytes.rows
	map.cols = bytes.cols

	for i, byte in ipairs(bytes) do
		if i > 1024 then
			break
		end
		map[byte[1]][byte[2]] = true
	end

	local result = bfs_exit(map, 0, 0, map.rows - 1, map.cols - 1)
	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		bfs_exit = bfs_exit,
	}
else
	run()
end
