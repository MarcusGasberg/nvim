local auto_session_ok, auto_session = pcall(require,"rmagatti/auto-session")

if not auto_session_ok then
	print("Auto session is not installed")
	return
end

auto_session.setup()
