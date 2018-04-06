function doThing(ifile)
    local rifile = io.open(ifile, "r")

    for line in rifile:lines() do
        if string.match(line, 'Nom: %u%l*%s%u%l*%s%u%l*') ~= nil then
            print("OK-->"..line)
        elseif string.match(line, 'email: %l+@%l+%.%l+') ~= nil then
            print("OK-->"..line)
        elseif string.match(line, 'Telf: %d9') ~= nil then
            print("OK-->"..line)
        else
            print("FATAL-->"..line)
        end
    end
end


local ifile = "./tests/testcontact.txt"
doThing(ifile)