vim.cmd("command! -bang -nargs=0 SageLink :lua require('sage.link.plain').set_link()")
vim.cmd("command! -bang -nargs=0 SageLinkRange :lua require('sage.link.plain').set_link_range()")
