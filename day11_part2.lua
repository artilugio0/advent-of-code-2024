local day11 = require("day11_part1")

local memo = {}
local function expand_stone(n, iterations)
	if iterations == 0 then
		return 1
	end

	if memo[n] ~= nil and memo[n][iterations] ~= nil then
		return memo[n][iterations]
	end

	local result = 0
	if n == 0 then
		result = expand_stone(1, iterations - 1)
	elseif #tostring(n) % 2 == 0 then
		local half_index = #tostring(n) / 2
		result = expand_stone(tonumber(string.sub(n, 1, half_index)), iterations - 1)
		result = result + expand_stone(tonumber(string.sub(n, half_index + 1)), iterations - 1)
	else
		result = expand_stone(n * 2024, iterations - 1)
	end

	if memo[n] == nil then
		memo[n] = {}
	end
	memo[n][iterations] = result

	return result
end

local function run()
	local stones = day11.read_input()

	local result = 0
	for i, s in ipairs(stones) do
		result = result + expand_stone(s, 75)
	end

	print(tostring(result))
end

run()
