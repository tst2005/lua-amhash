#! /usr/bin/env luajit

local amhash = require "amhash".amhash

local ascii = {""}
for i=0,255 do
	table.insert(ascii, string.char(i))
end

-- ascii = { "", "\0", ... "a", "b", ... }

--for len=1,5 do
local function brutforce(prefix, ascii, i, j)
	for _i, c in ipairs(ascii, i, j) do
		print(amhash(prefix..c))
	end
end

for _i, p0 in ipairs(ascii) do
	for _i, p1 in ipairs(ascii) do
		brutforce(p0..p1, ascii)
	end
end
