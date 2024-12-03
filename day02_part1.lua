local function read_input()
	local reports = {}

	local line = io.read("*line")
	while line ~= nil do
		local report = {}
		for str in string.gmatch(line, "%d+") do
			local num = tonumber(str)
			if num == nil then
				break
			end

			table.insert(report, num)
		end

		if #report > 0 then
			table.insert(reports, report)
		end
		line = io.read("*line")
	end

	return reports
end

local function report_is_safe(rep)
	local last = nil
	local increasing = nil

	for _, value in ipairs(rep) do
		if last == nil then
			last = value
			goto next_value
		end

		if increasing == nil then
			increasing = value > last
		end

		if increasing and value <= last then
			return false
		elseif not increasing and value >= last then
			return false
		end

		if math.abs(value - last) > 3 then
			return false
		end

		last = value

		::next_value::
	end

	return true
end


local function run()
	local reports = read_input()
	local safe_reports = 0

	for _, rep in ipairs(reports) do
		if report_is_safe(rep) then
			safe_reports = safe_reports + 1
		end
	end

	print(safe_reports)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		report_is_safe = report_is_safe,
	}
else
	run()
end
