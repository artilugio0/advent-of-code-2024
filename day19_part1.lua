local function read_input()
	local towels = {}
	local patterns = {}

	local lines = io.lines()
	for t in string.gmatch(lines(), "[a-z]+") do
		towels[t] = true
	end
	lines()

	for p in lines do
		if p == "" then
			break
		end

		table.insert(patterns, p)
	end

	return towels, patterns
end

local function is_possible(p, towels)
	if #p == 0 then
		return true
	end

	for pl = 1, #p do
		if towels[string.sub(p, 1, pl)] then
			if is_possible(string.sub(p, pl + 1), towels) then
				return true
			end
		end
	end

	return false
end

local function run()
	local towels, patterns = read_input()

	local count = 0
	for _, p in ipairs(patterns) do
		if is_possible(p, towels) then
			count = count + 1
		else
			print("impossible", p)
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
