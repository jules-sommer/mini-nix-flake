BH = {
	buffers = {},
	currentBuffer = nil,
	currentWindow = nil,
	currentTab = nil,
}

BH.getBuffers = function()
	return vim.api.nvim_list_bufs()
end

BH.closeCurrentBuffer = function()
	if vim.fn.confirm("Are you sure you want to delete this file?", "&Yes\n&No", 2) == 1 then
		-- Get the full path of the current buffer
		local file = vim.fn.expand('%:p')

		-- Check if the file is readable (exists)
		if vim.fn.filereadable(file) == 1 then
			-- Delete the file
			vim.fn.delete(file)
		end

		-- Close the buffer
		vim.cmd('bd')
	end
end

-- vim.api.nvim_create_user_command('CloseAndDelete', confirm_delete, {})
