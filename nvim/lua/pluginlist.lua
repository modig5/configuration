return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme gruvbox")
		end
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',

			'hrsh7th/cmp-nvim-lsp',

		},
	},
	{
  {
    "echasnovski/mini.pick",
    version = false, -- track latest
    config = function()
      local pick = require("mini.pick")
      pick.setup()

      -- handy mappings
      vim.keymap.set("n", "<leader>ff", function() pick.builtin.files() end)
      vim.keymap.set("n", "<leader>fg", function() pick.builtin.grep_live() end) -- needs ripgrep
      vim.keymap.set("n", "<leader>fb", function() pick.builtin.buffers() end)
      vim.keymap.set("n", "<leader>fh", function() pick.builtin.help() end)
    end,
  },
}


}
