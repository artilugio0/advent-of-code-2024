local day17 = require("day17_part1")

local function run()
	local a, b, c, program = day17.read_input()
	local outputs = {}

	a = 0
	local target_num_index = 0
	while true do
		_, _, _, _, outputs = day17.run_program(a, b, c, program)

		for i = 0, target_num_index do
			if outputs[#outputs - i] ~= program[#program - i] then
				goto next
			end
		end

		if #outputs == #program then
			break
		end

		a = a * 8 - 1
		target_num_index = target_num_index + 1

		::next::
		a = a + 1
	end
	print(a)
end

run()
