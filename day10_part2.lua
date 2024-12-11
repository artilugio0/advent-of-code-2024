local day10 = require("day10_part1")

local function trailhead_rating(map, r, c)
	local level = map[r][c]
	if level == 9 then
		return 1
	end

	local rows = #map
	local cols = #map[1]

	local rating = 0
	if r < rows and map[r + 1][c] == level + 1 then
		rating = rating + trailhead_rating(map, r + 1, c)
	end

	if r > 1 and map[r - 1][c] == level + 1 then
		rating = rating + trailhead_rating(map, r - 1, c)
	end

	if c < cols and map[r][c + 1] == level + 1 then
		rating = rating + trailhead_rating(map, r, c + 1)
	end

	if c > 1 and map[r][c - 1] == level + 1 then
		rating = rating + trailhead_rating(map, r, c - 1)
	end

	return rating
end

local function run()
	local map = day10.read_input()

	local rating = 0
	for r, row in ipairs(map) do
		for c, v in ipairs(row) do
			if v == 0 then
				rating = rating + trailhead_rating(map, r, c)
			end
		end
	end

	print(rating)
end

run()
