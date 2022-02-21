local cli = {}

function cli.handle(cmd, args)
    if cmd == "l" then
        require("sage.link."..args).set_link()
    elseif cmd == "t" then
        if args == "row" then
            require("sage.live_table").row()
        elseif args == "range" then
            require("sage.live_table").range()
        elseif args == "table" then
            require("sage.live_table").table()
        elseif args == "apply" then
            require("sage.live_table").apply()
        end
    end
end

function cli.completion(cmd)
    if string.find(cmd, "SageLink") then
        return "plain\nimage\nheading"
    elseif string.find(cmd, "SageTable") then
        return "line\nrange\ntable\napply"
    end
end

return cli
