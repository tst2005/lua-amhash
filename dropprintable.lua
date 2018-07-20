local ok=true

io.stdout:write(io.stdin:read("*a"):gsub(".", function(c)
	local v = string.byte(c)
	if v == 0x09 or v == 0x0a or v == 0x0d or c == " " then
		return c
	end
	if ( v >= 0x20 and v <= 0x7e ) then
		return "-"
	else
		ok=false
		return "X"
	end
end).."\n")

os.exit(ok and 0 or 1)
