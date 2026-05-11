vim.o.guifont = "Iosevka Nerd Font:h14"

local function apply_theme(force) 
    if (force or vim.v.option_old == "light") and vim.o.background == "dark" then
      vim.cmd("colorscheme dracula")
    elseif (force or vim.v.option_old == "dark") and vim.o.background == "light" then
      vim.cmd("colorscheme dayfox")
    end
end

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = apply_theme
})

apply_theme(true)


 vim.opt.spelllang = { "ru_yo", "en_us" } 
