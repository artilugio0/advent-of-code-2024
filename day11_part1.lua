local function read_input()
	local stones = {}

	local input = io.read()

	for s in string.gmatch(input, "%d+") do
		table.insert(stones, tonumber(s))
	end

	return stones
end

local function run()
	local stones = read_input()

	for i = 1, 25 do
		local new_arrangement = {}

		for _, n in ipairs(stones) do
			if n == 0 then
				table.insert(new_arrangement, 1)
			elseif #tostring(n) % 2 == 0 then
				local half_index = #tostring(n) / 2
				table.insert(new_arrangement, tonumber(string.sub(n, 1, half_index)))
				table.insert(new_arrangement, tonumber(string.sub(n, half_index + 1)))
			else
				table.insert(new_arrangement, tonumber(n * 2024))
			end
		end

		stones = new_arrangement
	end

	print(#stones)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
	}
else
	run()
end
