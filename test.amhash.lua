local amhash = require "amhash"
--                               2000000
--                                ffffff
--                               ffffffffffff
--assert(amhash("")=="00000001")
--assert(amhash("hello world!")=="047da995")
--assert(amhash("hello world!", 6,6)=="00047deba995")
amhash("hello world!")

if false then
	local rawamhash = amhash.rawamhash
	local tmp = {}
	tmp = rawamhash("hello ", tmp)
	tmp = rawamhash("world!", tmp)
	print(tmp) -- print a table
	amhash.auto(tmp)
	print(tmp) -- print the finalform value
	--amhash.finalform(tmp)
end

if true then
	local rawamhash = amhash.rawamhash
	local tmp = {}
	--tmp.debugprint=print

	local fd = io.stdin
	while true do
		local line = fd:read(4096)
		if not line then break end
		tmp = rawamhash(line, tmp)
	end
	amhash.auto(tmp)
	print(tmp)
end

