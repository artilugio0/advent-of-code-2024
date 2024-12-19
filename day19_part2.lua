local day19 = require("day19_part1")

local memo = {}

local function count_possible(p, towels)
	if memo[p] then
		return memo[p]
	end

	local count = 0
	if #p == 0 then
		memo[p] = 1
		return 1
	end

	for pl = 1, #p do
		if towels[string.sub(p, 1, pl)] then
			count = count + count_possible(string.sub(p, pl + 1), towels)
		end
	end

	memo[p] = count
	return count
end

local function run()
	local towels, patterns = day19.read_input()

	local count = 0
	for _, p in ipairs(patterns) do
		count = count + count_possible(p, towels)
	end

	print(count)
end

run()
