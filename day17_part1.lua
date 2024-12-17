local function read_input()
	local program = {}

	local lines = io.lines()
	local _, _, a = string.find(lines(), "(%d+)")
	local _, _, b = string.find(lines(), "(%d+)")
	local _, _, c = string.find(lines(), "(%d+)")
	lines()
	for n in string.gmatch(lines(), "(%d),?") do
		table.insert(program, tonumber(n))
	end

	return tonumber(a), tonumber(b), tonumber(c), program
end

local function combo(operand, a, b, c)
	if operand <= 3 then
		return operand
	end

	if operand == 4 then
		return a
	elseif operand == 5 then
		return b
	elseif 6 then
		return c
	else
		error("invalid combo operand " .. tostring(operand))
	end
end

local function print_machine(a, b, c, ip, outputs)
	print("Register A: " .. tostring(a))
	print("Register B: " .. tostring(b))
	print("Register C: " .. tostring(c))
	print("IP: " .. tostring(ip))

	local outputstr = ""
	for _, o in ipairs(outputs) do
		outputstr = outputstr .. "," .. tostring(o)
	end
	print("Outputs: " .. string.sub(outputstr, 2))
end

local function run_program(a, b, c, program)
	local outputs = {}

	local ip = 1
	while ip <= #program do
		local op = program[ip]
		local operand = program[ip + 1]
		local next_ip = ip + 2

		if op == 0 then
			a = math.floor(a / (2 ^ combo(operand, a, b, c)))
		elseif op == 1 then
			b = b ~ operand
		elseif op == 2 then
			b = combo(operand, a, b, c) % 8
		elseif op == 3 then
			if a ~= 0 then
				next_ip = operand + 1
			end
		elseif op == 4 then
			b = b ~ c
		elseif op == 5 then
			table.insert(outputs, combo(operand, a, b, c) % 8)
		elseif op == 6 then
			b = math.floor(a / (2 ^ combo(operand, a, b, c)))
		elseif op == 7 then
			c = math.floor(a / (2 ^ combo(operand, a, b, c)))
		end

		ip = next_ip
	end

	return a, b, c, ip, outputs
end

local function run()
	local a, b, c, program = read_input()
	local outputs
	local ip

	a, b, c, ip, outputs = run_program(a, b, c, program)

	print_machine(a, b, c, ip, outputs)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		run_program = run_program,
		print_machine = print_machine,
		combo = combo,
	}
else
	run()
end
