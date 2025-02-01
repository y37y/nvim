local M = {}
local system = vim.loop.os_uname().sysname

function M.core_mappings(mappings)
  if not mappings then mappings = require("astrocore").empty_map_table() end

  local maps = mappings.core
  if maps then
    maps.n["<Leader>n"] = false
    maps.n["<Leader>s"] = { desc = require("astroui").get_icon("GrugFar", 1, true) .. "Search" }
    maps.v["<Leader>s"] = { desc = require("astroui").get_icon("GrugFar", 1, true) .. "Search" }

    maps.n.n = { require("utils").better_search "n", desc = "Next search" }
    maps.n.N = { require("utils").better_search "N", desc = "Previous search" }
    maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
    maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }
    maps.n["n"] = { "nzz" }
    maps.n["N"] = { "Nzz" }
    -- close search highlight
    maps.n["<Leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight", silent = true }

    maps.n["H"] = { "^", desc = "Go to start without blank" }
    maps.n["L"] = { "$", desc = "Go to end without blank" }

    maps.v["<"] = { "<gv", desc = "Unindent line" }
    maps.v[">"] = { ">gv", desc = "Indent line" }
    maps.t["<Esc>"] = { [[<C-\><C-n>]], desc = "Exit terminal mode" }

    -- Clipboard mappings
    maps.v["<leader>y"] = { '"+y', desc = "Copy selected text to system clipboard" }
    maps.v["<leader>Y"] = { '"+Y', desc = "Copy selected line to system clipboard" }
    maps.n["<leader>y"] = { '"+y', desc = "Yank to system clipboard" }
    maps.n["<leader>Y"] = { '"+Y', desc = "Yank line to system clipboard" }
    maps.n["y"] = { '"+y', desc = "Copy to system clipboard" }
    maps.v["y"] = { '"+y', desc = "Copy to system clipboard" }
    maps.n["<leader>ya"] = { ':%y+<CR>', desc = "Yank entire buffer to system clipboard" }

    -- Buffer select mapping
    maps.n["<leader>a"] = {
      function()
          vim.cmd('normal! gg0')
          vim.cmd('normal! vG$')
      end,
      desc = "Select entire buffer from start to end"
    }

    -- Vertical diff mapping
    maps.n["<leader>dv"] = {
      function()
        vim.cmd('vnew')
        vim.cmd('normal! "+P')
        vim.cmd('windo diffthis')
      end,
      desc = "Vertical diff split with clipboard"
    }

    -- Cut without copy in visual mode
    maps.n["x"] = { '"_x', desc = "Cut without copy" }
    -- lsp restart
    maps.n["<Leader>lm"] = { "<Cmd>LspRestart<CR>", desc = "Lsp restart" }
    maps.n["<Leader>lg"] = { "<Cmd>LspLog<CR>", desc = "Show lsp log" }

    -- macOS specific mappings
    if system == "Darwin" then
      maps.i["<D-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.x["<D-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.n["<D-s>"] = { "<Cmd>w<cr>", desc = "Save file", silent = true }
    end

    -- Enable Ctrl+hjkl navigation in debug/test mode
    for _, mode in ipairs({ "n", "i", "v" }) do
      maps[mode]["<C-h>"] = {
        function()
          require("astrocore").move_selection "h"
        end,
        desc = "Move to left screen",
      }
      maps[mode]["<C-j>"] = {
        function()
          require("astrocore").move_selection "j"
        end,
        desc = "Move to bottom screen",
      }
      maps[mode]["<C-k>"] = {
        function()
          require("astrocore").move_selection "k"
        end,
        desc = "Move to top screen",
      }
      maps[mode]["<C-l>"] = {
        function()
          require("astrocore").move_selection "l"
        end,
        desc = "Move to right screen",
      }
    end

    -- window
    local get_icon = require("astroui").get_icon
    maps.n["<Leader>w"] = { name = get_icon("Window", 1, true) .. "Window" }
    maps.n["<Leader>wc"] = { "<C-w>c", desc = "Close current screen" }
  end
  return mappings
end

return M
