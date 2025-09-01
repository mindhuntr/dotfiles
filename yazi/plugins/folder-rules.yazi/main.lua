local function setup()
	ps.sub("cd", function()
		local cwd = cx.active.current.cwd
		if cwd:ends_with("Downloads") or cwd:ends_with("x_saves") or cwd:ends_with("reddit_saves") then
			ya.emit("sort", { "btime", reverse = true, dir_first = true })
		elseif cwd:ends_with("pins") or cwd:ends_with("wallpapers") or cwd:ends_with("Telegram Desktop") then
			ya.emit("sort", { "btime", reverse = true, dir_first = true })
		else
			ya.emit("sort", { "alphabetical", reverse = false, dir_first = true })
		end
	end)
end

return { setup = setup }
