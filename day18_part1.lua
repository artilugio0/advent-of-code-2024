local function read_input()
	local bytes = {}
	local rows = 0
	local cols = 0
	for line in io.lines() do
		if line == "" then
			break
		end

		local _, e, c = string.find(line, "(%d+)")
		local _, _, r = string.find(line, "(%d+)", e + 1)
		r = tonumber(r)
		c = tonumber(c)

		if r ~= nil and r > rows then
			rows = r
		end
		if c ~= nil and c > cols then
			cols = c
		end

		table.insert(bytes, { r, c })
	end
	bytes.rows = rows + 1
	bytes.cols = cols + 1

	return bytes
end

local function hpush(h, p, v)
	local prio = p(v)
	table.insert(h, v)
	local i = #h

	local pari = math.floor(i / 2)
	while h[pari] and prio < p(h[pari]) do
		h[i], h[pari] = h[pari], h[i]
		i = pari
		pari = math.floor(i / 2)
	end
end

local function hpop(h, p)
	local v = h[1]
	local l = table.remove(h)
	if #h == 0 then
		return v
	end
	h[1] = l

	local i = 1
	local c1 = i * 2
	local c2 = i * 2 + 1
	while h[c1] ~= nil do
		if (not h[c2] or p(h[c1]) <= p(h[c2])) and p(h[c1]) < p(h[i]) then
			h[c1], h[i] = h[i], h[c1]
			i = c1
		elseif h[c2] and p(h[c2]) < p(h[c1]) and p(h[c2]) < p(h[i]) then
			h[c2], h[i] = h[i], h[c2]
			i = c2
		else
			break
		end

		c1 = i * 2
		c2 = i * 2 + 1
	end

	return v
end

local function steps_to_exit(map, sr, sc, er, ec)
	local prio = {}
	for r = 0, map.rows - 1 do
		prio[r] = {}
		for c = 0, map.cols - 1 do
			prio[r][c] = 1 / 0
		end
	end
	local priority = function(x)
		return x[3]
	end

	local adj = function(r, c)
		local a = {}
		if map[r - 1] ~= nil and not map[r - 1][c] then
			table.insert(a, { r - 1, c })
		end
		if map[r + 1] ~= nil and not map[r + 1][c] then
			table.insert(a, { r + 1, c })
		end
		if map[r][c - 1] ~= nil and not map[r][c - 1] then
			table.insert(a, { r, c - 1 })
		end
		if map[r][c + 1] ~= nil and not map[r][c + 1] then
			table.insert(a, { r, c + 1 })
		end

		return a
	end

	prio[sr][sc] = 0
	local pq = { { sr, sc, 0 } }

	while #pq > 0 do
		local x = hpop(pq, priority)
		if x[1] == er and x[2] == ec then
			break
		end

		local this_prio = prio[x[1]][x[2]]
		for _, a in ipairs(adj(x[1], x[2])) do
			if this_prio + 1 < prio[a[1]][a[2]] then
				prio[a[1]][a[2]] = this_prio + 1
				hpush(pq, priority, { a[1], a[2], this_prio + 1 })
			end
		end
	end

	return prio[er][ec]
end

local function run()
	local bytes = read_input()

	local map = {}
	for r = 0, bytes.rows - 1 do
		map[r] = {}
		for c = 0, bytes.cols - 1 do
			map[r][c] = false
		end
	end
	map.rows = bytes.rows
	map.cols = bytes.cols

	for i, byte in ipairs(bytes) do
		if i > 1024 then
			break
		end
		map[byte[1]][byte[2]] = true
	end

	local result = steps_to_exit(map, 0, 0, map.rows - 1, map.cols - 1)
	print(result)
end

if pcall(debug.getlocal, 4, 1) then
	return {
		read_input = read_input,
		steps_to_exit = steps_to_exit,
	}
else
	run()
end
