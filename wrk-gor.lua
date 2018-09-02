local counter = 1

function setup(thread)
    thread:set("id", counter)
    counter = counter + 1
end

function init(args)
    local filename
    for i=1,#args,2 do
        if args[i] == '-g' or args[i] == '--gor' then
            filename = args[i+1]
        end
    end
    assert(filename, 'missing `-g` or `--goreplay` arguments!')
    local f, errmsg, errno = io.open(filename, 'rb')
    if not f then
        error("open gor file error: " .. errmsg)
    end

    print("loading data from file `" .. filename .. "` for thread #" .. id)
    i = 1
    requests = {}
    while true do
        meta = getline(f)
        request = getrequest(f)
        if meta == nil or request == nil then
            break
        end
        table.insert(requests, request)
    end
end

function request()
    if i > #requests then
        i = 1
    end
    r = requests[i]
    i = i + 1
    return r
end

local buf = nil

function getline(f)
    local l = ''
    while true do
        if not buf then
            buf = f:read(4096)
            if buf == nil then
                return nil
            end
        end
        local n = buf:find('\n')
        if n == nil then
            l = l .. buf
            buf = nil
        else
            l = l .. buf:sub(0, n)
            buf = buf:sub(n)
            break
        end
    end
    return l
end

function getrequest(f)
    local r = ''
    while true do
        if not buf then
            buf = f:read(4096)
            if buf == nil then
                return nil
            end
        end
        local s, e = buf:find("\n\xf0\x9f\x90\xb5\xf0\x9f\x99\x88\xf0\x9f\x99\x89\n")
        if s == nil then
            r = r .. buf
            buf = nil
        else
            r = r .. buf:sub(0, s)
            buf = buf:sub(e)
            break
        end
    end
    return r
end
