vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":NERDTreeToggle<CR>", { desc = "[P]roject tree [V]iew" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move select text down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move select text up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "[J]oin with next line" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "[P]aste over" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "[Y]ank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+y", { desc = "[Y]ank to system clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "[D]elete without replacing buffer" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "[D]elete without replacing buffer" })

vim.keymap.set("n", "<leader>t", ":!printTodos<CR>", { desc = "Scan files for and print [T]odos" })
vim.keymap.set("n", "<leader>x", ":source %<CR>", { desc = "E[x]ecute current file as source" })

vim.keymap.set("n", "<leader>qt", ":tabclose<CR>", { desc = "[Q]uit [T]ab" })
vim.keymap.set("n", "<leader>nt", ":tabnext<CR>", { desc = "[N]ext [T]ab" })
vim.keymap.set("n", "<leader>pt", ":tabprev<CR>", { desc = "[P]revious [T]ab" })

local config_tab_id = -1
vim.keymap.set("n", "<leader>ocm", 
function()
    local config_path = vim.fn.stdpath("config")

    if (vim.api.nvim_tabpage_is_valid(config_tab_id)) then
        vim.api.nvim_set_current_tabpage(config_tab_id)
        vim.cmd(":e! " .. config_path)
    else
        vim.cmd(":tabnew " .. config_path)
        config_tab_id = vim.api.nvim_get_current_tabpage()
        vim.cmd(":tc " .. config_path)
    end
end,
{ desc = "[O]pen [c]onfiguration - [m]ain directory" })

local function is_buf_visible_in_tabpage(buf_id)
    if (not vim.api.nvim_buf_is_valid(buf_id)) then
        return false, nil
    end

    local win_ids = vim.api.nvim_tabpage_list_wins(0)
    for __, win_id in ipairs(win_ids) do
        local win_buf = vim.api.nvim_win_get_buf(win_id)
        
        if (win_buf == buf_id) then
            return true, win_id
        end
    end

    return false, nil
end

local terminal_buf = -1
vim.keymap.set("n", "<leader>`", function()
    if (vim.api.nvim_buf_is_valid(terminal_buf)) then
        if (vim.api.nvim_get_current_buf() == terminal_buf) then
            vim.api.nvim_win_close(0, false)
        else
            local is_visible, win_id = is_buf_visible_in_tabpage(terminal_buf)
            if (is_visible) then
                vim.api.nvim_set_current_win(win_id)
            else
                vim.cmd.vsplit()
                vim.api.nvim_set_current_buf(terminal_buf)
                vim.cmd.wincmd("J")
            end
        end
    else
        vim.cmd.vsplit()
        vim.cmd.term()
        terminal_buf = vim.fn.bufnr()
        vim.cmd.wincmd("J")
    end
end,
{ desc = "Open terminal" })

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
