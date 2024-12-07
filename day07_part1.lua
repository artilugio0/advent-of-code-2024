local function read_input()
	local equations = {}

	for line in io.lines() do
		if line == "" then
			break
		end

		local nums = string.gmatch(line, "%d+")
		local result = tonumber(nums())

		local numbers = {}
		for n in nums do
			table.insert(numbers, tonumber(n))
		end

		table.insert(equations, { result, numbers })
	end

	return equations
end

local function can_be_made_true(result, values)
	if #values == 1 then
		return result == values[1]
	end

	local first_values = { table.unpack(values, 1, #values - 1) }
	local last = values[#values]

	return can_be_made_true(result - last, first_values)
		or result % last == 0 and can_be_made_true(result / last, first_values)
end

local function run()
	local equations = read_input()
	local result = 0
	for _, eq in ipairs(equations) do
		if can_be_made_true(eq[1], eq[2]) then
			result = result + eq[1]
		end
	end

	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
