local function finalform(o)
	local na, nm, ha, hm, ha2 = o.na, o.nm, o.ha, o.hm, o.ha2
	local modha, modhm = (16^na), (16^nm)
	local modha2 = modha
	local r = (("%0."..(na).."x"):format(ha % modha)).." "..(("%0."..(nm).."x"):format(hm % modhm)).." "..(("%0."..(na).."x"):format(ha2 % modha))
	return r
end


local function amhash(data, o, readsize, readoffset)
	o = o or {}
	local na, nm, ha, hm, ha2, i = o.na, o.nm, o.ha, o.hm, o.ha2, o.i
	local debugprint = o.debugprint
	readsize = (readsize or #data) + (readoffset or 0)

	ha = ha or 0
	ha2 = ha2 or 0
	hm = hm or 1
	i = (i or 0)

	local na = na or 8 -- max 16
	local nm = nm or 10 -- max 16
	local modha = (16^na)
	local modhm = (16^nm)
	local maxint = 2^52 -- (512TB)
	local sub,byte = string.sub, string.byte

	--if debugprint then debugprint(finalform({na=na,nm=nm,ha=ha,hm=hm,ha2=ha2}), i, 0, i+0) end
	assert(readsize >= 0)
	for n=1,readsize do
		--local v = byte(sub(data,n,n))
		local v= byte(data,n,n)
		ha = (ha + v) % modha
		ha2 = (ha2 + ((i+n)%maxint) * (v+1)) % modha
		hm = ( hm * (v+1) ) % modhm +1
		if debugprint then debugprint(finalform({na=na,nm=nm,ha=ha,hm=hm,ha2=ha2}), i, n, i+n) end
	end
	i = i+readsize -- remember the next start for segmented processing
	o.na, o.nm, o.ha, o.hm, o.ha2, o.i = na, nm, ha, hm, ha2, i
	if debugprint then debugprint("return "..finalform(o), nil, i) end
	return o
end
local function auto(o)
	setmetatable(o, {__tostring=finalform})
end

local M ={}
M.rawamhash = amhash
M.finalform = finalform
M.auto = auto
M.amhash = function(...)
	return auto(amhash(...))
end

return setmetatable(M, {__call=function(_,...)
	return finalform(amhash(...))
end})
