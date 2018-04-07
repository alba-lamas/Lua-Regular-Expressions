function operate(val1, op, val2)
    local result = 0

    if isVar(val1) then
        val1 = variablesAssign[val1]
    end
    if isVar(val2) then
        val2 = variablesAssign[val2]
    end

    if op == "+" then
        result = tonumber(val1)+tonumber(val2)
    elseif op == "-" then
        result = tonumber(val1)-tonumber(val2)
    elseif op == "*" then
        result = tonumber(val1)*tonumber(val2)
    elseif op == "/" then
        result = tonumber(val1)/tonumber(val2)
    end

    print("La "..op.." de "..val1.." i "..val2.." es: "..result)
end

function isVar(param)
    return string.match(param, '%l') ~= nil
end

function getValues(matching)
    if string.match(matching, CALC..NUM..SPC..OP..SPC..NUM..SEMI..'+') ~= nil then
        return string.match(matching, CALC..'('..NUM..')'..SPC..'('..OP..')'..SPC..'('..NUM..')'..SEMI..'+')

    elseif string.match(matching, CALC..NUM..SPC..OP..SPC..VAR..SEMI..'+') ~= nil then
        return string.match(matching, CALC..'('..NUM..')'..SPC..'('..OP..')'..SPC..'('..VAR..')'..SEMI..'+')

    elseif string.match(matching, CALC..VAR..SPC..OP..SPC..NUM..SEMI..'+') ~= nil then
        return string.match(matching, CALC..'('..VAR..')'..SPC..'('..OP..')'..SPC..'('..NUM..')'..SEMI..'+')

    elseif string.match(matching, CALC..VAR..SPC..OP..SPC..VAR..SEMI..'+') ~= nil then
        return string.match(matching, CALC..'('..VAR..')'..SPC..'('..OP..')'..SPC..'('..VAR..')'..SEMI..'+')
    end
end

function getMatches(line)
    local patterns = {}
    i = 1
    if line:gmatch(CALC..NUM..SPC..OP..SPC..NUM..SEMI..'+') ~= nil then
        for matching in line:gmatch( CALC..NUM..SPC..OP..SPC..NUM..SEMI..'+') do
            patterns[i] = matching
            i=i+1
        end
    end
    if line:gmatch(CALC..NUM..SPC..OP..SPC..VAR..SEMI..'+') ~= nil then
        for matching in line:gmatch(CALC..NUM..SPC..OP..SPC..VAR..SEMI..'+') do
            patterns[i] = matching
            i=i+1
        end
    end
    if line:gmatch(CALC..VAR..SPC..OP..SPC..NUM..SEMI..'+') ~= nil then
        for matching in line:gmatch(CALC..VAR..SPC..OP..SPC..NUM..SEMI..'+') do
            patterns[i] = matching
            i=i+1
        end
    end
    if line:gmatch(CALC..VAR..SPC..OP..SPC..VAR..SEMI..'+') ~= nil then
        for matching in line:gmatch(CALC..VAR..SPC..OP..SPC..VAR..SEMI..'+') do
            patterns[i] = matching
            i=i+1
        end
    end

    return patterns
end

function isAssign(line)
    return string.match(line,'%l ?= ?%d+;') ~= nil
end

function doThing(ifile)
    local rifile = io.open(ifile, "r")
    for line in rifile:lines() do
        if isAssign(line) then
            variablesAssign[line:match('%l')] = line:match('%d+')
        else
            local patterns = {}
            patterns = getMatches(line)
            for j=1, #patterns do
                val1, op, val2 = getValues(patterns[j])
                operate(val1, op, val2)
            end
        end
    end
end

CALC = 'Calc: '
NUM = '%d+%.?%d*'
VAR = '%l'
OP = '[%+%-%*%/]'
SPC = '%s?'
SEMI = ';'
variablesAssign = {}

local ifile = "./tests/testcalc.txt"
doThing(ifile)