local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local cmp_nvim_lsp_signature_help = require("cmp_nvim_lsp_signature_help")
local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()

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

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    [ "<Up>" ] = cmp.mapping.select_prev_item(),
    [ "<Down>" ] = cmp.mapping.select_next_item(),
    [ "<Left>" ] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    [ "<Right>" ] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    [ "<Esc>" ] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    [ "<S-Tab>" ] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    [ "<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()  --cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, item)
      item.kind = string.format("%s", icons[item.kind])
      item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        -- buffer = "[Buffer]",
        -- path = "[Path]",
      })[entry.source.name]
      return item
    end,
  },
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})

cmp_nvim_lsp.setup()
cmp.register_source("nvim_lsp_signature_help", cmp_nvim_lsp_signature_help.new())
