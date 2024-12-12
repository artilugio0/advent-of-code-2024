local function read_input()
	local map = {}
	for line in io.lines() do
		if line == "" then
			break
		end

		local row = {}
		for c in string.gmatch(line, ".") do
			table.insert(row, c)
		end

		table.insert(map, row)
	end
	return map
end

local function area(map, r, c, seen)
	local key = string.format("%d,%d", r, c)
	if seen[key] then
		return 0
	end
	seen[string.format("%d,%d", r, c)] = true

	local right_area, left_area, up_area, down_area = 0, 0, 0, 0
	if map[r][c + 1] ~= nil and map[r][c + 1] == map[r][c] then
		right_area = area(map, r, c + 1, seen)
	end

	if map[r][c - 1] ~= nil and map[r][c - 1] == map[r][c] then
		left_area = area(map, r, c - 1, seen)
	end

	if map[r - 1] ~= nil and map[r - 1][c] == map[r][c] then
		up_area = area(map, r - 1, c, seen)
	end

	if map[r + 1] ~= nil and map[r + 1][c] == map[r][c] then
		down_area = area(map, r + 1, c, seen)
	end

	return left_area + right_area + up_area + down_area + 1
end

local function perimeter(map, r, c, seen)
	local key = string.format("%d,%d", r, c)
	if seen[key] then
		return 0
	end
	seen[string.format("%d,%d", r, c)] = true

	local this_perimeter = 4
	local right_perimeter, left_perimeter, up_perimeter, down_perimeter = 0, 0, 0, 0
	if map[r][c + 1] ~= nil and map[r][c + 1] == map[r][c] then
		this_perimeter = this_perimeter - 1
		right_perimeter = perimeter(map, r, c + 1, seen)
	end

	if map[r][c - 1] ~= nil and map[r][c - 1] == map[r][c] then
		this_perimeter = this_perimeter - 1
		left_perimeter = perimeter(map, r, c - 1, seen)
	end

	if map[r - 1] ~= nil and map[r - 1][c] == map[r][c] then
		this_perimeter = this_perimeter - 1
		up_perimeter = perimeter(map, r - 1, c, seen)
	end

	if map[r + 1] ~= nil and map[r + 1][c] == map[r][c] then
		this_perimeter = this_perimeter - 1
		down_perimeter = perimeter(map, r + 1, c, seen)
	end

	return left_perimeter + right_perimeter + up_perimeter + down_perimeter + this_perimeter
end

local function sides(map, r, c, seen)

end

local function run()
	local map = read_input()
	local seen = {}
	local seen_perim = {}

	local price = 0
	for r = 1, #map do
		for c = 1, #map[1] do
			if seen[string.format("%d,%d", r, c)] then
				goto next_plot
			end

			local region_area = area(map, r, c, seen)
			local region_perimeter = perimeter(map, r, c, seen_perim)

			price = price + region_area * region_perimeter
			::next_plot::
		end
	end
	print(price)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		area = area,
	}
else
	run()
end
