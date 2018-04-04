function saveTable(t, filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        print("file saved: "..path)
        return true
    else
        print("file not found"..path)
        return false
    end
end

function loadTable(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    print("load: "..path)
    local myTable = {}
    local file = io.open(path, "r")
    local contents = ""
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        myTable = json.decode(contents);
        io.close( file )
        return myTable
    else
        print("Cannot load file")
        return nil
    end
end


local M = {}

M.save = saveTable
M.load = loadTable

return M