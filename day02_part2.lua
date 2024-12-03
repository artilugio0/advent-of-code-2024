local day02 = require("day02_part1")

local function run()
	local reports = day02.read_input()
	local safe_reports = 0

	for _, rep in ipairs(reports) do
		if not day02.report_is_safe(rep) then
			local report_fixed = false

			for i = 1, #rep do
				local fixed_report = {}
				for k, v in ipairs(rep) do
					if k ~= i then
						table.insert(fixed_report, v)
					end
				end

				if day02.report_is_safe(fixed_report) then
					report_fixed = true
					break
				end
			end

			if not report_fixed then
				goto next_report
			end
		end

		safe_reports = safe_reports + 1

		::next_report::
	end

	print(safe_reports)
end

run()
