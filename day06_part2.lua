local day06 = require("day06_part1")

local function is_loop(map, x, y, dx, dy)
	local rows = #map
	local columns = #map[1]

	local max_count = rows*columns
	local count = 0
	while true do
		local newX = x + dx
		local newY = y + dy
		if newX <= 0 or newX > columns or newY <= 0 or newY > rows then
			break
		end

		local next_spot_occupied = map[newY][newX]
		if next_spot_occupied then
			dx, dy = -dy, dx
			goto next_step
		end

		count = count+1
		if count > max_count then
			return true
		end

		x, y = newX, newY
		::next_step::
	end

	return false
end

local function run()
	local map, x, y = day06.read_input()

	local rows = #map
	local columns = #map[1]
	local dx, dy = 0, -1

	local obstacles = {}
	local visited = { [string.format("%d,%d", y, x)] = true }

	while true do
		local newX = x + dx
		local newY = y + dy
		if newX <= 0 or newX > columns or newY <= 0 or newY > rows then
			break
		end

		local next_spot_occupied = map[newY][newX]

		if next_spot_occupied then
			dx, dy = -dy, dx
			goto next_step
		elseif not visited[string.format("%d,%d", newY, newX)] then
			map[newY][newX] = true
			if is_loop(map, x, y, dx, dy) then
				obstacles[string.format("%d,%d", newY, newX)] = true
			end
			map[newY][newX] = false
		end

		x, y = newX, newY
		visited[string.format("%d,%d", newY, newX)] = true

		::next_step::
	end

	local count = 0
	for _, _ in pairs(obstacles) do
		count = count + 1
	end

	print(count)
end


run()
