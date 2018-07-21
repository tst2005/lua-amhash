
--[[
# any value:

* 0 to N * 255   then reach after N = 4311810305
* 1 to ~256^N (limit reach after 4 chars!)
* 1*255 +2*255 +3*255 +4*255  (255*(1+2+3+4+...N))
	limit reach when (1+2+3+...+N) > 1099511627775/256
                                       > 4294967295
 limit reach at N = 92681 (reel)      4294930221
]]--

local function addn(n, v)
	v = v or n
	if n<=1 then
		return v
	end
	return addn(n-1, v+(n-1))
end
--print(addn(92681))

--     10 55
--    100 5050
--   1000 500500
--  10000 50005000
--  92862 4311721953 <------
-- 100000 5000050000

