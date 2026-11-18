function setup(config)
	config.action("open in editor", function()
		local file = context.file()

		if not file then
			flash("No file selected")
			return
		end

		exec_shell("$EDITOR " .. string.format("%q", file))
	end, {
		key = "e",
		scope = "revisions.details",
	})
end
