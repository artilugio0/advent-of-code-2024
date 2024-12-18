local day18 = require("day18_part1")

local function run()
	local bytes = day18.read_input()

	local limit = 1024
	while true do
		if limit % 100 == 0 then
			print(limit)
		end

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

		local result = day18.steps_to_exit(map, 0, 0, map.rows - 1, map.cols - 1)
		if result == 1 / 0 then
			print(string.format("%d,%d", bytes[limit][2], bytes[limit][1]))
			break
		end
		limit = limit + 1
	end
end

run()
