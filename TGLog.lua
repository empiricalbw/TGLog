TGLog = {}
TGLog.__index = TGLog

function TGLog:new(...)
    local log = {}
    setmetatable(log, self)
    log:TGLog(...)
    return log
end

function TGLog:TGLog(min_level, echo_level)
    -- Creates a TGLog object which filters all log messages whose level is
    -- below the TGLog object's minimum level.
    self.lines      = {}
    self.min_level  = min_level
    self.echo_level = echo_level
end

function TGLog:clear()
    self.lines = {}
end

function TGLog:log(level, ...)
    if level < min(self.min_level, self.echo_level) then
        return
    end

    local args = {n = select("#", ...), ...}
    local msg = ""
    for i=1, args.n do
        msg = msg..tostring(args[i])
    end

    if level >= self.min_level then
        table.insert(self.lines, msg)
    end

    if level >= self.echo_level then
        print(msg)
    end
end

function TGLog:dump()
    for _, msg in ipairs(self.lines) do
        print(msg)
    end
end
