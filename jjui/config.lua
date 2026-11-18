local ignore_immutable = false

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

	config.action("toggle ignore immutable", function()
		ignore_immutable = not ignore_immutable

		if ignore_immutable then
			flash("Ignore immutable is turned on")
		else
			flash("Ignore immutable is turned off")
		end
	end, {
		key = "I",
		scope = "revisions",
	})

	config.action("revisions.inline_describe.accept", function()
		jjui.builtin.revisions.inline_describe.accept({ force = ignore_immutable })
	end)

	config.action("revisions.squash.apply", function()
		jjui.builtin.revisions.squash.apply({ force = ignore_immutable })
	end)
end
