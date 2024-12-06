local function read_input()
	local map = {}
	local x, y = 1, 1
	local startX, startY = 0, 0
	for line in io.lines() do
		if line == "" then
			break
		end
		local row = {}
		for c in string.gmatch(line, ".") do
			if c == "^" then
				startX = x
				startY = y
			end

			table.insert(row, c == "#")
			x = x + 1
		end

		table.insert(map, row)
		y = y + 1
		x = 1
	end

	return map, startX, startY
end

local function run()
	local map, x, y = read_input()

	local rows = #map
	local columns = #map[1]
	local dx, dy = 0, -1

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
		end

		x, y = newX, newY
		visited[string.format("%d,%d", newY, newX)] = true

		::next_step::
	end

	local count = 0
	for _, _ in pairs(visited) do
		count = count + 1
	end

	print(count)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input
	}
else
	run()
end
