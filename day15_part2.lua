local day15 = require("day15_part1")

local function can_move(map, r, c, move)
	move = string.lower(move)
	if move == "<" then
		if map[r][c - 1] == "#" then
			return false
		elseif map[r][c - 1] == "." then
			return true
		elseif map[r][c - 1] == "[" or map[r][c - 1] == "]" then
			return can_move(map, r, c - 1, move)
		end
	elseif move == ">" then
		if map[r][c + 1] == "#" then
			return false
		elseif map[r][c + 1] == "." then
			return true
		elseif map[r][c + 1] == "[" or map[r][c + 1] == "]" then
			return can_move(map, r, c + 1, move)
		end
	elseif move == "^" then
		if map[r - 1][c] == "#" then
			return false
		elseif map[r - 1][c] == "." then
			return true
		elseif map[r - 1][c] == "[" then
			local can_move_left = can_move(map, r - 1, c, move)
			local can_move_right = can_move(map, r - 1, c + 1, move)
			return can_move_left and can_move_right
		elseif map[r - 1][c] == "]" then
			local can_move_left = can_move(map, r - 1, c - 1, move)
			local can_move_right = can_move(map, r - 1, c, move)
			return can_move_left and can_move_right
		end
	elseif move == "v" then
		if map[r + 1][c] == "#" then
			return false
		elseif map[r + 1][c] == "." then
			return true
		elseif map[r + 1][c] == "[" then
			local can_move_left = can_move(map, r + 1, c, move)
			local can_move_right = can_move(map, r + 1, c + 1, move)
			return can_move_left and can_move_right
		elseif map[r + 1][c] == "]" then
			local can_move_left = can_move(map, r + 1, c - 1, move)
			local can_move_right = can_move(map, r + 1, c, move)
			return can_move_left and can_move_right
		end
	end
	return r, c, false
end

local function move_cell(map, r, c, move)
	move = string.lower(move)
	if not can_move(map, r, c, move) then
		return r, c, false
	end

	if move == "<" then
		if map[r][c - 1] ~= "." then
			move_cell(map, r, c - 1, move)
		end
		map[r][c - 1] = map[r][c]
		map[r][c] = "."
		return r, c - 1, false
	elseif move == ">" then
		if map[r][c + 1] ~= "." then
			move_cell(map, r, c + 1, move)
		end
		map[r][c + 1] = map[r][c]
		map[r][c] = "."
		return r, c + 1, false
	elseif move == "^" then
		if map[r - 1][c] == "[" then
			move_cell(map, r - 1, c, move)
			move_cell(map, r - 1, c + 1, move)
		elseif map[r - 1][c] == "]" then
			move_cell(map, r - 1, c, move)
			move_cell(map, r - 1, c - 1, move)
		end
		map[r - 1][c] = map[r][c]
		map[r][c] = "."
		return r - 1, c, false
	elseif move == "v" then
		if map[r + 1][c] == "[" then
			move_cell(map, r + 1, c, move)
			move_cell(map, r + 1, c + 1, move)
		elseif map[r + 1][c] == "]" then
			move_cell(map, r + 1, c, move)
			move_cell(map, r + 1, c - 1, move)
		end
		map[r + 1][c] = map[r][c]
		map[r][c] = "."
		return r + 1, c, false
	end
	return r, c, false
end

local function transform_map(map)
	local transformed = {}
	for r = 1, map["rows"] do
		local row = {}
		for c = 1, map["cols"] do
			if map[r][c] == "O" then
				table.insert(row, "[")
				table.insert(row, "]")
			else
				table.insert(row, map[r][c])
				table.insert(row, map[r][c])
			end
		end
		table.insert(transformed, row)
	end
	transformed["rows"] = map["rows"]
	transformed["cols"] = map["cols"] * 2

	return transformed
end

local function run()
	local map, robot_row, robot_col, moves = day15.read_input()
	map = transform_map(map)
	robot_col = robot_col * 2 - 1
	local coords = 0

	for _, m in ipairs(moves) do
		robot_row, robot_col = move_cell(map, robot_row, robot_col, m)
	end

	for r = 1, map["rows"] do
		for c = 1, map["cols"] do
			if map[r][c] == "[" then
				coords = coords + 100 * (r - 1) + c - 1
			end
		end
	end

	print(coords)
end

run()
