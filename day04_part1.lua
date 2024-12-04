local function read_input()
	local t = {}

	for line in io.lines() do
		if line == "" then
			break
		end

		local row = {}
		for c in string.gmatch(line, "([A-Z])") do
			table.insert(row, c)
		end
		table.insert(t, row)
	end

	return t
end

local function run()
	local input = read_input()
	local rows = #input
	local cols = #input[1]

	local count = 0

	for row = 1, rows do
		for col = 1, cols do
			if
				col <= cols - 3
				and (
					(
						input[row][col] == "X"
						and input[row][col + 1] == "M"
						and input[row][col + 2] == "A"
						and input[row][col + 3] == "S"
					)
					or (
						input[row][col] == "S"
						and input[row][col + 1] == "A"
						and input[row][col + 2] == "M"
						and input[row][col + 3] == "X"
					)
				)
			then
				count = count + 1
			end

			if
				row <= rows - 3
				and (
					(
						input[row][col] == "X"
						and input[row + 1][col] == "M"
						and input[row + 2][col] == "A"
						and input[row + 3][col] == "S"
					)
					or (
						input[row][col] == "S"
						and input[row + 1][col] == "A"
						and input[row + 2][col] == "M"
						and input[row + 3][col] == "X"
					)
				)
			then
				count = count + 1
			end

			if
				row <= rows - 3
				and col <= cols - 3
				and (
					(
						input[row][col] == "X"
						and input[row + 1][col + 1] == "M"
						and input[row + 2][col + 2] == "A"
						and input[row + 3][col + 3] == "S"
					)
					or (
						input[row][col] == "S"
						and input[row + 1][col + 1] == "A"
						and input[row + 2][col + 2] == "M"
						and input[row + 3][col + 3] == "X"
					)
				)
			then
				count = count + 1
			end

			if
				row <= rows - 3
				and col >= 4
				and (
					(
						input[row][col] == "X"
						and input[row + 1][col - 1] == "M"
						and input[row + 2][col - 2] == "A"
						and input[row + 3][col - 3] == "S"
					)
					or (
						input[row][col] == "S"
						and input[row + 1][col - 1] == "A"
						and input[row + 2][col - 2] == "M"
						and input[row + 3][col - 3] == "X"
					)
				)
			then
				count = count + 1
			end
		end
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
