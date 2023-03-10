local bufn = -1
local output_bufn = -1

local M = {}

print("HELLO WORLD FROM SCRIPTO")

local function open_buffer()
	if bufn == -1 then
		vim.api.nvim_command("botright vnew")
		bufn = vim.api.nvim_get_current_buf()
	end
end

local function show_output(output)
	if output_bufn == -1 then
		vim.api.nvim_command("botright new")
		output_bufn = vim.api.nvim_get_current_buf()

		vim.api.nvim_buf_set_lines(output_bufn, 0, -1, false, { output })
	end
end

M.start = function()
	open_buffer()
end

local function get_content()
	local content = vim.api.nvim_buf_get_lines(bufn, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

M.run = function()
	local content = get_content()
	local output = vim.api.nvim_exec("osascript -e " + content, true)
	show_output(output)
end

return M
