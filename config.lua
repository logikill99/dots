-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--
lvim.builtin.treesitter.ensure_installed = {
    "python",
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }


vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {  "html" })
local opts = {
  filetypes = { "html", "htmldjango" }
}
require("lvim.lsp.manager").setup("html", opts)
require("lvim.lsp.manager").setup("tailwindcss", opts)

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg", -- lazy-load on filetype
    config = true, -- run require("neorg").setup()
  },
  { "savq/melange-nvim" },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, {
                "v-analyzer",
            })
        end
    end,
  },
  "AckslD/swenv.nvim",
  "strevear/dressing.nvim"
}

require('swenv').setup({
    post_set_venv = function()
        vim.cmd("LspRestart")
    end,
})

lvim.builtin.which_key.mappings["C"] = {
    name = "Python",
    c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.colorscheme = "melange"

vim.t.tabpage_number = 4
