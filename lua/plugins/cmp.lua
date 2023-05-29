local cmp = require("cmp")

local icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local completion = cmp.config.window.bordered()
local documentation = cmp.config.window.bordered()
completion.max_width = 40
documentation.max_width = 80

cmp.setup({
  enabled = function()
    return vim.bo.buftype ~= "prompt" and vim.bo.buftype ~= "nofile"
  end,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = completion,
    documentation = documentation,
  },
  mapping = cmp.mapping.preset.insert({
    [ "<Left>" ] = cmp.mapping.scroll_docs(-4),
    [ "<Right>" ] = cmp.mapping.scroll_docs(4),
    [ "<Esc>" ] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    [ "<Tab>" ] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "dap" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, item)
      item.kind = string.format("%s", icons[item.kind])
      item.menu = ({
        nvim_lsp = "[C]",
        luasnip = "[S]",
        buffer = "[B]",
        path = "[P]",
      })[entry.source.name]
      item.abbr = string.sub(item.abbr, 1, completion.max_width)
      return item
    end,
  },
})

--cmp.setup.cmdline("/", {
--  mapping = cmp.mapping.preset.cmdline(),
--  sources = {
--    { name = "buffer" }
--  }
--})

--cmp.setup.cmdline(":", {
--  mapping = cmp.mapping.preset.cmdline(),
--  sources = cmp.config.sources({
--    { name = "path" }
--  }, {
--    { name = "cmdline" }
--  })
--})

--cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
--  enabled = false,
--})
