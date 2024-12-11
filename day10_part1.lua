local function read_input()
	local map = {}
	for line in io.lines() do
		if line == "" then
			break
		end

		local row = {}
		for c in string.gmatch(line, ".") do
			table.insert(row, tonumber(c))
		end
		table.insert(map, row)
	end

	return map
end

local function trailhead_score(map, r, c, visited)
	if visited[string.format("%d,%d", r, c)] then
		return 0
	end

	visited[string.format("%d,%d", r, c)] = true

	local level = map[r][c]
	if level == 9 then
		return 1
	end

	local rows = #map
	local cols = #map[1]

	local score = 0
	if r < rows and map[r + 1][c] == level + 1 then
		score = score + trailhead_score(map, r + 1, c, visited)
	end

	if r > 1 and map[r - 1][c] == level + 1 then
		score = score + trailhead_score(map, r - 1, c, visited)
	end

	if c < cols and map[r][c + 1] == level + 1 then
		score = score + trailhead_score(map, r, c + 1, visited)
	end

	if c > 1 and map[r][c - 1] == level + 1 then
		score = score + trailhead_score(map, r, c - 1, visited)
	end

	return score
end

local function run()
	local map = read_input()

	local score = 0
	for r, row in ipairs(map) do
		for c, v in ipairs(row) do
			if v == 0 then
				score = score + trailhead_score(map, r, c, {})
			end
		end
	end

	print(score)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
