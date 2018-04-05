
function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
    if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

-- tests the functions above
local file = "testcalc.txt"
local lines = lines_from(file)

-- print all line numbers and their contents
for k,v in pairs(lines) do
    if string.match(v, 'Calc: %d+%.?%d* %+ %d+%.?%d*') ~= nil then
        print("OK-->"..v)
    end
end