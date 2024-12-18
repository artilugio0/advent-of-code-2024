local day18 = require("day18_part1")

local function run()
	local bytes = day18.read_input()

	local min_limit = 1024
	local max_limit = #bytes
	while true do
		if math.abs(min_limit - max_limit) <= 1 then
			break
		end
		local limit = math.floor((min_limit + max_limit) / 2)

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
			if i > limit then
				break
			end
			map[byte[1]][byte[2]] = true
		end

		local result = day18.bfs_exit(map, 0, 0, map.rows - 1, map.cols - 1)
		if result == nil then
			max_limit = limit
		else
			min_limit = limit
		end
	end

	print(string.format("%d,%d", bytes[max_limit][2], bytes[max_limit][1]))
end

run()
