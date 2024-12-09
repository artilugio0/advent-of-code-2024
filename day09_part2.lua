local day09 = require("day09_part1")

local function move_file(disk, space_index, file_index)
	while space_index < file_index do
		if disk[space_index][2] == disk[file_index][2] then
			disk[space_index][1] = disk[file_index][1]
			disk[file_index][1] = nil

			break
		elseif disk[space_index][2] >= disk[file_index][2] then
			local new_free_space = { nil, disk[space_index][2] - disk[file_index][2] }
			disk[space_index][1] = disk[file_index][1]
			disk[space_index][2] = disk[file_index][2]
			disk[file_index][1] = nil
			table.insert(disk, space_index + 1, new_free_space)

			break
		end

		space_index = space_index + 1
		while disk[space_index][1] ~= nil and space_index < file_index do
			space_index = space_index + 1
		end
	end
end

local function run()
	local disk = day09.read_input()
	local last_file_id = disk[#disk][1] ~= nil and disk[#disk][1] or disk[#disk - 1][1]

	while true do
		local space_index = 1
		while disk[space_index][1] ~= nil and space_index < #disk do
			space_index = space_index + 1
		end

		local file_index = #disk
		while (disk[file_index][1] == nil or disk[file_index][1] > last_file_id) and space_index < file_index do
			file_index = file_index - 1
		end

		if space_index >= file_index then
			break
		end

		move_file(disk, space_index, file_index)
		last_file_id = last_file_id - 1
	end

	print(day09.checksum(disk))
end

run()
