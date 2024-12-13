local day13 = require("day13_part1")

local function run()
	local machines = day13.read_input()
	local tokens = 0
	for _, m in ipairs(machines) do
		m.px = m.px + 10000000000000
		m.py = m.py + 10000000000000

		local na, nb = day13.machine_presses(m)
		tokens = tokens + na * 3 + nb
	end

	print(tokens)
end

run()
