local function read_input()
	local disk = {}
	local id = 0

	local is_file = true
	local input = io.read()
	for n in string.gmatch(input, ".") do
		if n == "\n" then
			break
		end

		local file_id = is_file and id or nil
		table.insert(disk, { file_id, tonumber(n) })

		is_file = not is_file
		id = is_file and id + 1 or id
	end

	return disk
end

local function print_disk(disk)
	for _, file_space in ipairs(disk) do
		local id = file_space[1] ~= nil and file_space[1] or "."

		for _ = 1, file_space[2] do
			io.write(id)
		end
	end
	print("")
end

local function checksum(disk)
	local result = 0
	local pos = 0
	for _, file in ipairs(disk) do
		if file[1] == nil then
			goto next_file
		end

		for i = 0, file[2] - 1 do
			result = result + (pos + i) * file[1]
		end

		::next_file::
		pos = pos + file[2]
	end

	return result
end

local function run()
	local disk = read_input()

	local free_space_index = 2
	local last = disk[#disk][1] ~= nil and #disk or #disk - 1

	while last > free_space_index do
		if disk[free_space_index][2] == disk[last][2] then
			disk[free_space_index][1] = disk[last][1]
			disk[last][1] = nil
			free_space_index = free_space_index + 2
			last = last - 2
		elseif disk[free_space_index][2] < disk[last][2] then
			disk[free_space_index][1] = disk[last][1]
			disk[last][2] = disk[last][2] - disk[free_space_index][2]
			free_space_index = free_space_index + 2
		else
			local new_free_space = { nil, disk[free_space_index][2] - disk[last][2] }
			disk[free_space_index][1] = disk[last][1]
			disk[free_space_index][2] = disk[last][2]
			disk[last][1] = nil
			disk[last][2] = 0
			table.insert(disk, free_space_index + 1, new_free_space)
			free_space_index = free_space_index + 1
			last = last - 1
		end
	end

	print(checksum(disk))
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		checksum = checksum,
		print_disk = print_disk,
	}
else
	run()
end
