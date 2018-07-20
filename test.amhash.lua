#! /usr/bin/env luajit

local amhash = require "amhash"

-- show defaults
if false then
	local rawamhash = amhash.rawamhash
	local o = rawamhash("")
	print("defaults: { na = "..o.na..", nm = "..o.nm.." }")
end

assert(amhash("",		{na=8, nm=10})=="00000000 0000000001 00000000")
assert(amhash("amhash",		{na=8, nm=10})=="00000272 3dcffe829e 000008bb")
assert(amhash("hello world!", 	{na=8, nm=10})=="0000047d 8b2eeba995 00001c2a")

assert(amhash("",               {na=10, nm=12})=="0000000000 000000000001 0000000000")
assert(amhash("amhash",		{na=10, nm=12})=="0000000272 013dcffe829e 00000008bb")
assert(amhash("hello world!", 	{na=10, nm=12})=="000000047d 228b2ef15fb7 0000001c2a")

-- test multi segment hash calculation
do
	local rawamhash = amhash.rawamhash
	local auto = amhash.auto

	local tmp = {}
	tmp = rawamhash("hello ", tmp)
	tmp = rawamhash("world!", tmp)
	assert(string.find( tostring(tmp), "^table: ")) -- a table
	auto(tmp)
	assert(string.find( tostring(tmp), "^[0-9a-f ]*$")) -- the finalform value
end

if true then
	local rawamhash = amhash.rawamhash
	local auto = amhash.auto

	local tmp = {}
	--tmp.debugprint=print

	local fd = io.stdin
	while true do
		local line = fd:read(4096)
		if not line then break end
		tmp = rawamhash(line, tmp)
	end
	auto(tmp)
	print(tmp)
end

