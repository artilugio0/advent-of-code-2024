local function read_input()
	local robots = {}

	for line in io.lines() do
		if line == "" then
			break
		end
		for px, py, vx, vy in string.gmatch(line, "p=(%d+),(%d+) v=(-?%d+),(-?%d+)") do
			table.insert(robots, {
				px = px,
				py = py,
				vx = vx,
				vy = vy,
			})
		end
	end

	return robots
end

local function run()
	local robots = read_input()
	local seconds = 100
	local width = 101
	local height = 103

	local q1, q2, q3, q4 = 0, 0, 0, 0
	for _, r in ipairs(robots) do
		local final_px = (r.px + r.vx * seconds) % width
		local final_py = (r.py + r.vy * seconds) % height

		if final_px < (width - 1) / 2 and final_py < (height - 1) / 2 then
			q1 = q1 + 1
		elseif final_px < (width - 1) / 2 and final_py >= (height + 1) / 2 then
			q2 = q2 + 1
		elseif final_px >= (width + 1) / 2 and final_py < (height - 1) / 2 then
			q3 = q3 + 1
		elseif final_px >= (width + 1) / 2 and final_py >= (height + 1) / 2 then
			q4 = q4 + 1
		end
	end

	print(q1 * q2 * q3 * q4)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
