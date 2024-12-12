local day12 = require("day12_part1")

local function perimeter_coords(map, r, c, seen, coords)
	local key = string.format("%d,%d", r, c)
	if seen[key] then
		return
	end
	seen[string.format("%d,%d", r, c)] = true

	if map[r][c + 1] == nil or map[r][c + 1] ~= map[r][c] then
		coords[string.format("vr(%d,%d)", r, c)] = true
	else
		perimeter_coords(map, r, c + 1, seen, coords)
	end

	if map[r][c - 1] == nil or map[r][c - 1] ~= map[r][c] then
		coords[string.format("vl(%d,%d)", r, c)] = true
	else
		perimeter_coords(map, r, c - 1, seen, coords)
	end

	if map[r - 1] == nil or map[r - 1][c] ~= map[r][c] then
		coords[string.format("ht(%d,%d)", r, c)] = true
	else
		perimeter_coords(map, r - 1, c, seen, coords)
	end

	if map[r + 1] == nil or map[r + 1][c] ~= map[r][c] then
		coords[string.format("hb(%d,%d)", r, c)] = true
	else
		perimeter_coords(map, r + 1, c, seen, coords)
	end
end

local function sides(map, r, c)
	local coords = {}
	perimeter_coords(map, r, c, {}, coords)

	local coords_seen = {}
	local count = 0

	for start_coord, _ in pairs(coords) do
		if coords_seen[start_coord] then
			goto next_start_coord
		end
		coords_seen[start_coord] = true
		count = count + 1

		local dir, cr, cc = string.match(start_coord, "(..)%((%d+),(%d+)%)")
		if dir == "ht" then
			for i = 1, #map[1] do
				local next_coord = string.format("ht(%d,%d)", cr, cc + i)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
			for i = 1, #map[1] do
				local next_coord = string.format("ht(%d,%d)", cr, cc - i)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
		elseif dir == "hb" then
			for i = 1, #map[1] do
				local next_coord = string.format("hb(%d,%d)", cr, cc + i)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
			for i = 1, #map[1] do
				local next_coord = string.format("hb(%d,%d)", cr, cc - i)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
		elseif dir == "vl" then
			for i = 1, #map[1] do
				local next_coord = string.format("vl(%d,%d)", cr + i, cc)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
			for i = 1, #map[1] do
				local next_coord = string.format("vl(%d,%d)", cr - i, cc)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
		elseif dir == "vr" then
			for i = 1, #map[1] do
				local next_coord = string.format("vr(%d,%d)", cr + i, cc)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
			for i = 1, #map[1] do
				local next_coord = string.format("vr(%d,%d)", cr - i, cc)
				if not coords[next_coord] then
					break
				end
				coords_seen[next_coord] = true
			end
		end

		::next_start_coord::
	end

	return count
end

local function run()
	local map = day12.read_input()
	local seen = {}

	local price = 0
	for r = 1, #map do
		for c = 1, #map[1] do
			if seen[string.format("%d,%d", r, c)] then
				goto next_plot
			end

			local region_area = day12.area(map, r, c, seen)
			local region_sides = sides(map, r, c)

			price = price + region_area * region_sides

			::next_plot::
		end
	end
	print(price)
end

run()
