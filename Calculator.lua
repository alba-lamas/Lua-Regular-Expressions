function operate(operation)
    local result = 0

    if operation[2] == "+" then
        result = tonumber(operation[1])+tonumber(operation[3])
    elseif operation[2] == "-" then
        result = tonumber(operation[1])-tonumber(operation[3])
    elseif operation[2] == "*" then
        result = tonumber(operation[1])*tonumber(operation[3])
    elseif operation[2] == "/" then
        result = tonumber(operation[1])/tonumber(operation[3])
    end

    print("La "..operation[2].." de "..operation[1].." i "..operation[3].." es: "..result)
end

function isCalc(line)
    return string.match(line,'Calc: %d+ ?[%+%-%*%/] ?%d+;+') ~= nil
end

function isAssign(line)
    return string.match(line,'%l ?= ?%d+;') ~= nil
end

function doThing(ifile)
    local rifile = io.open(ifile, "r")
    for line in rifile:lines() do
        if isCalc(line) then
            for matching in line:gmatch('%d+ ?[%+%-%*%/] ?%d+;+') do
                local operation = {}
                for values in matching:gmatch('[%d+%+%-%*%/]') do
                    table.insert(operation, values)
                end
                operate(operation)
            end


        elseif isAssign(line) then
            variablesAssign[line:match('%l')] = line:match('%d+')
        end

    end
end

variablesAssign = {}
local ifile = "./tests/testcalc.txt"
doThing(ifile)