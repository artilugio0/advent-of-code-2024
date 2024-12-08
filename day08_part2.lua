local day08 = require("day08_part1")

local function run()
	local antennas, rows, cols = day08.read_input()
	local antinodes = {}

	for _, ants in pairs(antennas) do
		for i, a1 in ipairs(ants) do
			local next_antennas = { table.unpack(ants, i + 1) }
			for _, a2 in ipairs(next_antennas) do
				local drow = a1[1] - a2[1]
				local dcol = a1[2] - a2[2]

				local anti1_row, anti1_col = a1[1], a1[2]
				local anti2_row, anti2_col = a2[1], a2[2]

				while anti1_row >= 1 and anti1_row <= rows and anti1_col >= 1 and anti1_col <= cols do
					antinodes[string.format("%d %d", anti1_row, anti1_col)] = true
					anti1_row, anti1_col = anti1_row + drow, anti1_col + dcol
				end

				while anti2_row >= 1 and anti2_row <= rows and anti2_col >= 1 and anti2_col <= cols do
					antinodes[string.format("%d %d", anti2_row, anti2_col)] = true
					anti2_row, anti2_col = anti2_row - drow, anti2_col - dcol
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

run()
