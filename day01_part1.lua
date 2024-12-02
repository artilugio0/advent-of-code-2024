local function print_table(t)
	for k, v in pairs(t) do
		print(k, v)
	end
end

local function read_input()
	local lists = { {}, {} }

	local line = io.read("*line")
	while line ~= nil do
		local i = 1
		for str in string.gmatch(line, "%d+") do
			local num = tonumber(str)
			if num == nil then
				break
			end

			table.insert(lists[i], num)
			i = i + 1
		end
		line = io.read("*line")
	end

	return lists
end

local function run()
	local lists = read_input()

	table.sort(lists[1])
	table.sort(lists[2])

	local lists_distance = 0
	for i = 1, #lists[1] do
		lists_distance = lists_distance + math.abs(lists[1][i] - lists[2][i])
	end

	print(lists_distance)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
