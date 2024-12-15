local function read_input()
	local map = {}
	local robot_row, robot_col = 0, 0
	local moves = {}
	local map_done = false

	local r = 0
	for line in io.lines() do
		if line == "" then
			map["rows"] = r
			map_done = true
			goto next_line
		end

		if map_done then
			if line == "" then
				break
			end

			for i = 1, #line do
				table.insert(moves, string.sub(line, i, i))
			end
			goto next_line
		end

		r = r+1
		local row = {}
		for i = 1, #line do
			local c = string.sub(line, i, i)
			if c == "@" then
				robot_row, robot_col = r, i
				c = '.'
			end
			row[i] = c
		end
		map[r] = row
		map["cols"] = #line

		::next_line::
	end

	return map, robot_row, robot_col, moves
end

local function move_cell(map, r, c, move)
	move = string.lower(move)
	if move == "<" then
		if map[r][c-1] == "#" then
			return r, c, false
		elseif map[r][c-1] == "." then
			map[r][c-1] = map[r][c]
			map[r][c] = "."
			return r, c-1, true
		elseif map[r][c-1] == "O" then
			local _, _, was_moved = move_cell(map, r, c-1, move)
			if was_moved then
				map[r][c-1] = map[r][c]
				map[r][c] = "."
				return r, c-1, true
			end
			return r, c, false
		end
	elseif move == ">" then
		if map[r][c+1] == "#" then
			return r, c, false
		elseif map[r][c+1] == "." then
			map[r][c+1] = map[r][c]
			map[r][c] = "."
			return r, c+1, true
		elseif map[r][c+1] == "O" then
			local _, _, was_moved = move_cell(map, r, c+1, move)
			if was_moved then
				map[r][c+1] = map[r][c]
				map[r][c] = "."
				return r, c+1, true
			end
			return r, c, false
		end
	elseif move == "^" then
		if map[r-1][c] == "#" then
			return r, c, false
		elseif map[r-1][c] == "." then
			map[r-1][c] = map[r][c]
			map[r][c] = "."
			return r-1, c, true
		elseif map[r-1][c] == "O" then
			local _, _, was_moved = move_cell(map, r-1, c, move)
			if was_moved then
				map[r-1][c] = map[r][c]
				map[r][c] = "."
				return r-1, c, true
			end
			return r, c, false
		end
	elseif move == "v" then
		if map[r+1][c] == "#" then
			return r, c, false
		elseif map[r+1][c] == "." then
			map[r+1][c] = map[r][c]
			map[r][c] = "."
			return r+1, c, true
		elseif map[r+1][c] == "O" then
			local _, _, was_moved = move_cell(map, r+1, c, move)
			if was_moved then
				map[r+1][c] = map[r][c]
				map[r][c] = "."
				return r+1, c, true
			end
			return r, c, false
		end
	end
	return r, c, false
end

local function run()
	local map, robot_row, robot_col, moves = read_input()

	for _, m in ipairs(moves) do
		robot_row, robot_col = move_cell(map, robot_row, robot_col, m)
	end

	local coords = 0
	for r = 1,map["rows"] do
		for c = 1,map["cols"] do
			if map[r][c] == "O" then
				coords = coords + 100 * (r-1) + c -1
			end
		end
	end

	print(coords)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input
	}
else
	run()
end
