local ignore_immutable = false
local IGNORE_IMMUTABLE_FLAG = "--ignore-immutable"

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

	config.action("revisions.edit", function()
		if ignore_immutable then
			jjui.builtin.revisions.force_edit()
		else
			jjui.builtin.revisions.edit()
		end
	end)

	config.action("revisions.split", function()
		if not ignore_immutable then
			jjui.builtin.revisions.split()
			return
		end

		local change_id = context.change_id()
		if change_id then
			jj_interactive("split", "-r", change_id, IGNORE_IMMUTABLE_FLAG)
			jjui.revisions.refresh()
		end
	end)
end
