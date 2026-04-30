---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = true,
      signature_help = true,
      inline_completion = true,
      linked_editing_range = false,
      semantic_tokens = true
    },
    formatting = {
      format_on_save = {
        enabled = false
      }
    }
  }
}
