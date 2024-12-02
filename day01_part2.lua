local day01 = require("day01_part1")

local function run()
	local lists = day01.read_input()

	local counts = {}
	for _, num in ipairs(lists[2]) do
		if counts[num] == nil then
			counts[num] = 0
		end

		counts[num] = counts[num] + 1
	end

	local similarity_score = 0
	for _, num in ipairs(lists[1]) do
		similarity_score = similarity_score + num * (counts[num] or 0)
	end

	print(similarity_score)
end

if not pcall(debug.getlocal, 4, 1) then
	run()
end
