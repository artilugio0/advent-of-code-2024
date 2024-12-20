local function read_input()
	local racetrack = {}
	local rstart
	local rend

	local r = 0
	for line in io.lines() do
		r = r + 1
		if line == "" then
			break
		end

		local row = {}
		local c = 0
		for v in string.gmatch(line, "(.)") do
			c = c + 1
			if v == "S" then
				rstart = { r, c }
				v = "."
			elseif v == "E" then
				rend = { r, c }
				v = "."
			end

			table.insert(row, v)
		end
		table.insert(racetrack, row)
	end

	racetrack.rows = #racetrack
	racetrack.cols = #racetrack[1]
	racetrack.rstart = rstart
	racetrack.rend = rend

	return racetrack
end

local function key(coord)
	return string.format("%d,%d", coord[1], coord[2])
end

local function print_map(map, r, c)
	for row = 1, map.rows do
		for col = 1, map.cols do
			if row == r and col == c then
				io.write("O")
			else
				io.write(map[row][col])
			end
		end
		print("")
	end
end

local memo = {}
local function time_to_end(map, sr, sc, er, ec, seen)
	if memo[key({ sr, sc })] then
		return memo[key({ sr, sc })]
	end

	if seen == nil then
		seen = {}
	end

	seen[key({ sr, sc })] = true
	if sr == er and sc == ec then
		memo[key({ sr, sc })] = 0
		return 0
	end

	for _, delta in ipairs({ { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }) do
		local coords = { sr + delta[1], sc + delta[2] }
		local spot = map[coords[1]][coords[2]]
		if spot == "." and not seen[key(coords)] then
			local t = time_to_end(map, coords[1], coords[2], er, ec, seen)
			if t then
				memo[key({ sr, sc })] = 1 + t
				return 1 + t
			end
		end
	end
end

local function time_to_end_with_cheat(map)
	local result = {}
	for r = 1, map.rows do
		for c = 1, map.cols do
			if map[r][c] == "." then
				for _, delta in ipairs({ { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }) do
					if
						map[r + delta[1] * 2]
						and map[r + delta[1] * 2][c + delta[2] * 2]
						and map[r + delta[1]][c + delta[2]] == "#"
						and map[r + delta[1] * 2][c + delta[2] * 2] == "."
					then
						local time_to_here = memo[key(map.rstart)] - memo[key({ r, c })]
						time_to_end(map, r + delta[1] * 2, c + delta[2] * 2, map.rend[1], map.rend[2])
						local time_to_end_after_cheat =
							time_to_end(map, r + delta[1] * 2, c + delta[2] * 2, map.rend[1], map.rend[2])
						local time_with_cheat = 2 + time_to_here + time_to_end_after_cheat

						if result[time_with_cheat] then
							result[time_with_cheat] = result[time_with_cheat] + 1
						else
							result[time_with_cheat] = 1
						end
					end
				end
			end
		end
	end

	return result
end

local function run()
	local racetrack = read_input()
	local time = time_to_end(racetrack, racetrack.rstart[1], racetrack.rstart[2], racetrack.rend[1], racetrack.rend[2])
	local times_with_cheat = time_to_end_with_cheat(racetrack)

	local result = 0
	for cheat_time, count in pairs(times_with_cheat) do
		if time - cheat_time >= 80 then
			result = result + count
		end
	end
	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		time_to_end = time_to_end,
		key = key,
	}
else
	run()
end
