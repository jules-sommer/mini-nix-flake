function table.asSet(t)
	local set = {}
	for _, v in ipairs(t) do
		set[v] = true
	end
	return set
end

function table.intersect(t1, t2)
	local res = {}
	for _, v in ipairs(t1) do
		if t2[v] then
			table.insert(res, v)
		end
	end
	return res
end

function table.map(t, f)
	local res = {}
	for _, v in ipairs(t) do
		table.insert(res, f(v))
	end
	return res
end

function table.filter(t, f)
	local res = {}
	for _, v in ipairs(t) do
		if f(v) then
			table.insert(res, v)
		end
	end
	return res
end

return table
