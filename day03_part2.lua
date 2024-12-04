local function read_input()
	local instructions = {}

	local mul_enabled = true
	for line in io.lines() do
		if line == "" then
			goto next_line
		end

		local start = 1

		while true do
			if not mul_enabled then
				local _, do_end = string.find(line, "do%(%)", start)
				if do_end == nil then
					break
				end

				mul_enabled = true
				start = do_end + 1
				goto next_match
			end

			local mul_start, mul_end = string.find(line, "mul%((%d+),(%d+)%)", start)
			if mul_start == nil then
				break
			end

			local dont_start, dont_end = string.find(line, "don't%(%)", start)
			if dont_start ~= nil and dont_start < mul_start then
				mul_enabled = false
				start = dont_end + 1
				goto next_match
			end

			local op1, op2 = string.match(line, "mul%((%d+),(%d+)%)", mul_start)
			table.insert(instructions, { tonumber(op1), tonumber(op2) })
			start = mul_end + 1

			::next_match::
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
