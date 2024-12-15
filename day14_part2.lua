local day14 = require("day14_part1")

local function run()
	local robots = day14.read_input()
	local width = 101
	local height = 103

	-- hopefully the drawing has a straight line
	local horizontal_line_length = 10

	-- at the second width * height all robots are
	-- in the starting position because the deltas are
	-- 0 mod width and 0 mod height
	for seconds = 0, width * height do
		local occupied = {}
		for _, r in ipairs(robots) do
			local x = (r.px + r.vx * seconds) % width
			local y = (r.py + r.vy * seconds) % height
			occupied[string.format("%d,%d", x, y)] = true
		end

		for y = 0, height - 1 do
			local count = 0
			for x = 0, width - 1 do
				if occupied[string.format("%d,%d", x, y)] then
					count = count + 1
				else
					count = 0
				end
				if count == horizontal_line_length then
					print(seconds)
					return
				end
			end
		end
	end
end

run()
