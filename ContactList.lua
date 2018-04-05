
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
local file = "testcontact.txt"
local lines = lines_from(file)

-- print all line numbers and their contents
for k,v in pairs(lines) do
    matched = false
    if string.match(v, 'Nom: %u%l*%s%u%l*%s%u%l*') ~= nil then
        print("OK-->"..v)
    elseif string.match(v, 'email: %l+@%l+%.%l+') ~= nil then
        print("OK-->"..v)
    elseif string.match(v, 'Telf: %d9') ~= nil then
        print("OK-->"..v)
    else
        print("FATAL-->"..v)
    end
end