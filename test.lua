local amhash = require "amhash".amhash

--print(amhash( ("\0"):rep(10) ))
for i=92681,92682,1 do
print(i, amhash( ("\255"):rep(i) ))
end

