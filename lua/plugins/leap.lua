local leap_ok, leap = pcall(require,"leap")

if not leap_ok then
	print("Leap is not installed")
	return
end

leap.add_default_mappings()
leap.init_highlight(true)

