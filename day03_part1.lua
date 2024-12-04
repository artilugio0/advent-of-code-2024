local function read_input()
	local instructions = {}

	for line in io.lines() do
		if line == "" then
			goto next_line
		end

		for a, b in string.gmatch(line, "mul%((%d+),(%d+)%)") do
			table.insert(instructions, { tonumber(a), tonumber(b) })
		end

		::next_line::
	end

	return instructions
end

local function run()
	local instructions = read_input()

	local result = 0
	for _, inst in ipairs(instructions) do
		result = result + inst[1] * inst[2]
	end

	print(result)
end

run()
