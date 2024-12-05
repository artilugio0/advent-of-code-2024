local day05 = require("day05_part1")

local function run()
	local rules, updates = day05.read_input()

	local result = 0
	for _, update in ipairs(updates) do
		if day05.update_is_correct(update, rules) then
			goto next_update
		end

		table.sort(update, function(a, b)
			local after_a = rules[a]
			return after_a ~= nil and after_a[b] ~= nil
		end)

		result = result + day05.update_middle_page(update)

		::next_update::
	end

	print(result)
end

run()
