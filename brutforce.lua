#! /usr/bin/env luajit

local amhash = require "amhash".amhash

local ascii = {}
for i=0,255 do
	table.insert(ascii, string.char(i))
end
-- ascii = { "\0", ... "a", "b", ... }

local ascii = {"\t", "\n", "\r"}
--             0x09  0x0a  0x0d
for i=0x20,0x7e do
	table.insert(ascii, string.char(i))
end

local function printable(data)
	return (#(string.gsub(data, ".", function(c)
		local v = string.byte(c)
		if v == 0x09 or v == 0x0a or v == 0x0d or ( v >= 0x20 and v <= 0x7e ) then
			return ""
		else
			return "x"
		end
	end))==0)
end

--print ( printable("abc") )
--print ( printable("a\0bc") )
--print ( printable("foo é bar") )

local jump = nil
if arg[1] then jump = tonumber(arg[1]) end

local function brutforce(prefix, ascii, i, j)
	for _i, c in ipairs(ascii, i, j) do
		local opt = {}
		if jump then opt.i = jump end
		print(amhash(prefix..c, opt)..":", string.byte(prefix..c, 1, -1))
	end
end

io.stderr:write("alphabet len: "..#ascii.."\n")
local p1,p2,p3 = "","",""
-- for _i, p1 in ipairs(ascii) do
--	for _i, p2 in ipairs(ascii) do
		for _i, p3 in ipairs(ascii) do
			brutforce(p1..p2..p3, ascii)
		end
-- 	end
-- end
