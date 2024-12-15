local day07 = require("day07_part1")

local function can_be_made_true(result, values)
	if #values == 1 then
		return result == values[1]
	end

	local first_values = { table.unpack(values, 1, #values - 1) }
	local last = values[#values]

	local resultstr = tostring(result)
	local laststr = tostring(last)
	local result_ends_with_last = #resultstr > #laststr and string.sub(resultstr, -#laststr) == laststr
	if result_ends_with_last then
		local resultstr_without_laststr = string.sub(resultstr, 1, #resultstr - #laststr)
		if can_be_made_true(tonumber(resultstr_without_laststr), first_values) then
			return true
		end
	end

	return can_be_made_true(result - last, first_values)
		or result % last == 0 and can_be_made_true(math.floor(result / last), first_values)
end

local function run()
	local equations = day07.read_input()

	local result = 0
	for _, eq in ipairs(equations) do
		if can_be_made_true(eq[1], eq[2]) then
			result = result + eq[1]
		end
	end

	print(result)
end

run()
