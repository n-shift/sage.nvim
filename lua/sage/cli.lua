local cli = {}

function cli.handle(cmd, args)
    if cmd == "l" then
        require("sage.link."..args).set_link()
    end
end

function cli.completion(cmd)
    if string.find(cmd, "SageLink") then
        return "plain\nimage"
    end
end

return cli
