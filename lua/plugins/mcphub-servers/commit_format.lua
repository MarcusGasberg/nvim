local mcphub = require("mcphub")

-- Add a tool for extracting the branch name's issue number
mcphub.add_tool("commit_format", {
  name = "extract_issue_number",
  description = "Extract the issue number from the Git branch name to use in commit messages",
  handler = function(req, res)
    local branch = vim.fn.system("git branch --show-current"):gsub("[ ]", "")

    -- Try to extract issue number from branch name
    -- Common formats: feature/JIRA-123, bugfix/LY-4039, etc.
    local issue_number = branch:match("%w+[/-](%w+%-%d+)%W*") or
        branch:match("%w+[/-](%w+%d+)%W*") or
        branch:match("(%w+%-%d+)")

    if not issue_number then
      return res:error("Could not extract issue number from branch name: " .. branch)
    end

    return res:text(issue_number):send()
  end
})

-- Add a wrapper for git_commit that prepends the issue number
mcphub.add_tool("commit_format", {
  name = "commit_with_issue",
  description = "Create a Git commit with the issue number from branch name as prefix",
  inputSchema = {
    type = "object",
    properties = {
      message = {
        type = "string",
        description = "Commit message without the issue number prefix"
      }
    },
    required = { "message" }
  },
  handler = function(req, res)
    -- First extract the issue number
    local branch = vim.fn.system("git branch --show-current"):gsub("[ ]", "")

    -- Try to extract issue number from branch name
    local issue_number = branch:match("%w+[/-](%w+%-%d+)%W*") or
        branch:match("%w+[/-](%w+%d+)%W*") or
        branch:match("(%w+%-%d+)")

    if not issue_number then
      return res:error("Could not extract issue number from branch name: " .. branch)
    end

    -- Format the commit message with the issue number prefix
    local formatted_message = issue_number .. ": " .. req.params.message

    -- Run the git commit command
    local commit_cmd = string.format('git commit -m "%s"', formatted_message:gsub('"', '\\"'))
    local output = vim.fn.system(commit_cmd)
    local success = vim.v.shell_error == 0

    if not success then
      return res:error("Git commit failed: " .. output)
    end

    return res:text("Commit created with message: " .. formatted_message):send()
  end
})

-- Add a prompt for creating a commit with issue number
mcphub.add_prompt("commit_format", {
  name = "create_commit",
  description = "Create a Git commit with the issue number from branch name as prefix",
  arguments = {
    {
      name = "message",
      description = "Commit message without the issue number prefix",
      required = true
    }
  },
  handler = function(req, res)
    local branch = vim.fn.system("git branch --show-current"):gsub("[ ]", "")
    local issue_number = branch:match("%w+[/-](%w+%-%d+)%W*") or
        branch:match("%w+[/-](%w+%d+)%W*") or
        branch:match("(%w+%-%d+)")

    if not issue_number then
      issue_number = "UNKNOWN"
    end

    return res
        :user()
        :text(string.format("Help me write a commit message for branch %s with the issue number %s as a prefix", branch,
          issue_number))
        :llm()
        :text(string.format("I'll help you create a commit message for your branch with the %s issue number as prefix.",
          issue_number))
        :text(string.format(
          "Here's a suggested commit message format:\n\n**%s: %s**\n\nYou can use this as a starting point and customize it as needed.",
          issue_number, req.params.message))
        :text(
          "Remember that good commit messages should:\n- Be clear and concise\n- Describe what was changed and why\n- Use the imperative mood (e.g., 'Fix bug' rather than 'Fixed bug')\n- Include any relevant context")
        :send()
  end
})

-- Return empty since we're using the incremental approach
return {}
