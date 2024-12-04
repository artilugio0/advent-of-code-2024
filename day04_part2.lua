local day04 = require("day04_part1")

local function run()
	local input = day04.read_input()
	local rows = #input
	local cols = #input[1]

	local count = 0

	for row = 1, rows - 2 do
		for col = 1 - 2, cols do
			if
				(
					(input[row][col] == "M" and input[row + 1][col + 1] == "A" and input[row + 2][col + 2] == "S")
					or (input[row][col] == "S" and input[row + 1][col + 1] == "A" and input[row + 2][col + 2] == "M")
				)
				and (
					(input[row + 2][col] == "M" and input[row + 1][col + 1] == "A" and input[row][col + 2] == "S")
					or (input[row + 2][col] == "S" and input[row + 1][col + 1] == "A" and input[row][col + 2] == "M")
				)
			then
				count = count + 1
			end
		end
	end

	print(count)
end

run()
