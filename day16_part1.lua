local function read_input()
	local map = {}
	local start_row = 0
	local start_col = 0
	local end_row = 0
	local end_col = 0

	local r = 0
	for line in io.lines() do
		if line == "" then
			break
		end
		r = r + 1

		local c = 1
		local row = {}
		for v in line:gmatch(".") do
			if v == "S" then
				start_row = r
				start_col = c
				v = "."
			elseif v == "E" then
				end_row = r
				end_col = c
				v = "."
			end

			table.insert(row, v)
			c = c + 1
		end

		table.insert(map, row)
		map["cols"] = #line
	end
	map["rows"] = r

	return map, start_row, start_col, end_row, end_col
end

local function copy_table(t)
	local result = {}
	for k, v in pairs(t) do
		result[k] = v
	end
	return result
end

local function best_score(map, start_row, start_col, end_row, end_col, dr, dc)
	local visited = {}
	if dr == nil and dc == nil then
		dr, dc = 0, 1
	end

	local next_steps = { { start_row, start_col, dr, dc, 0, {} } }

	while #next_steps > 0 do
		local srow, scol, sdr, sdc, sscore, path = table.unpack(table.remove(next_steps))
		path[string.format("%d,%d", srow, scol)] = sscore

		if srow == end_row and scol == end_col then
			return sscore, path
		end

		if map[srow][scol] == "#" or visited[string.format("%d,%d", srow, scol)] then
			goto next
		end

		visited[string.format("%d,%d", srow, scol)] = true

		table.insert(next_steps, { srow + sdr, scol + sdc, sdr, sdc, sscore + 1, copy_table(path) })
		table.insert(next_steps, { srow + sdc, scol - sdr, sdc, -sdr, sscore + 1 + 1000, copy_table(path) })
		table.insert(next_steps, { srow - sdr, scol - sdc, -sdr, -sdc, sscore + 1 + 2000, copy_table(path) })
		table.insert(next_steps, { srow - sdc, scol + sdr, -sdc, sdr, sscore + 1 + 1000, copy_table(path) })

		table.sort(next_steps, function(a, b)
			return a[5] > b[5]
		end)

		::next::
	end
end

local function run()
	local map, start_row, start_col, end_row, end_col = read_input()
	local result = best_score(map, start_row, start_col, end_row, end_col)
	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		best_score = best_score,
	}
else
	run()
end
