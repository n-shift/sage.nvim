vim.cmd("command! -bang -nargs=0 SageLink :lua require('sage').set_link()")
vim.cmd("command! -bang -nargs=0 SageLinkRange :lua require('sage').set_link_range()")
