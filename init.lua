require("josean.core.options")
require("josean.core")
require("josean.lazy")

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\r//g]])
    vim.fn.winrestview(save)
  end,
})
