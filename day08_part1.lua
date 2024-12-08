local function read_input()
	local antennas = {}

	local row = 0
	local col = 0
	for line in io.lines() do
		if line == "" then
			break
		end
		row = row + 1
		col = 0
		for c in string.gmatch(line, ".") do
			col = col + 1
			if c ~= "." then
				if antennas[c] == nil then
					antennas[c] = {}
				end

				table.insert(antennas[c], { row, col })
			end
		end
	end

	return antennas, row, col
end

local function run()
	local antennas, rows, cols = read_input()
	local antinodes = {}

	for _, ants in pairs(antennas) do
		for i, a1 in ipairs(ants) do
			local next_antennas = { table.unpack(ants, i + 1) }
			for _, a2 in ipairs(next_antennas) do
				local drow = a1[1] - a2[1]
				local dcol = a1[2] - a2[2]

				local anti1_row, anti1_col = a1[1] + drow, a1[2] + dcol
				local anti2_row, anti2_col = a2[1] - drow, a2[2] - dcol

				if anti1_row >= 1 and anti1_row <= rows and anti1_col >= 1 and anti1_col <= cols then
					antinodes[string.format("%d %d", anti1_row, anti1_col)] = true
				end

				if anti2_row >= 1 and anti2_row <= rows and anti2_col >= 1 and anti2_col <= cols then
					antinodes[string.format("%d %d", anti2_row, anti2_col)] = true
				end
			end
		end
	end

	local count = 0
	for _ in pairs(antinodes) do
		count = count + 1
	end

	print(count)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
