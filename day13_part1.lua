local function read_input()
	local machines = {}

	local next_line = io.lines()
	local input = next_line()
	while input do
		if input == "" then
			input = next_line()
			goto continue
		end

		local _, _, ax, ay = string.find(input, "(%d+).+%D(%d+)")
		local _, _, bx, by = string.find(next_line(), "(%d+).+%D(%d+)")
		local _, _, px, py = string.find(next_line(), "(%d+).+%D(%d+)")

		table.insert(machines, {
			ax = ax,
			ay = ay,
			bx = bx,
			by = by,
			px = px,
			py = py,
		})

		input = next_line()
		::continue::
	end

	return machines
end

local function machine_presses(m)
	local det = m.ax * m.by - m.ay * m.bx
	local na = (m.by * m.px - m.bx * m.py) / det
	local nb = (m.ax * m.py - m.ay * m.px) / det

	if na ~= math.floor(na) or nb ~= math.floor(nb) then
		return 0, 0
	end

	return math.floor(na), math.floor(nb)
end

local function run()
	local machines = read_input()
	local tokens = 0
	for _, m in ipairs(machines) do
		local na, nb = machine_presses(m)
		tokens = tokens + na * 3 + nb
	end

	print(tokens)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		machine_presses = machine_presses,
	}
else
	run()
end
