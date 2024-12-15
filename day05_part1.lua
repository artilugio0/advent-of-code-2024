local function read_input()
	local rules = {}
	local updates = {}

	for line in io.lines() do
		if line == "" then
			break
		end

		local x, y = string.gmatch(line, "(%d+)|(%d+)")()
		local rule = rules[x]
		if rule ~= nil then
			rules[x][y] = true
		else
			rules[x] = { [y] = true }
		end
	end

	for line in io.lines() do
		if line == "" then
			break
		end

		local update = {}
		for page in string.gmatch(line, "%d+") do
			table.insert(update, page)
		end

		table.insert(updates, update)
	end

	return rules, updates
end

local function update_is_correct(update, rules)
	local seen = {}
	for _, page in ipairs(update) do
		local after_pages = rules[page]
		if after_pages == nil then
			goto next_page
		end

		for _, x in ipairs(seen) do
			if after_pages[x] ~= nil then
				return false
			end
		end

		::next_page::
		table.insert(seen, page)
	end

	return true
end

local function update_middle_page(update)
	local middle_index = math.floor(#update / 2) + (#update % 2 == 0 and 0 or 1)
	return math.floor(update[middle_index])
end

local function run()
	local rules, updates = read_input()

	local result = 0
	for _, update in ipairs(updates) do
		if not update_is_correct(update, rules) then
			goto next_update
		end

		-- find middle page
		result = result + update_middle_page(update)

		::next_update::
	end

	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		update_is_correct = update_is_correct,
		update_middle_page = update_middle_page,
	}
else
	run()
end
