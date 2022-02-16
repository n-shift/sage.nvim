function! ArgCompletion(A, L, P)
    return luaeval("require('sage.cli').completion(_A)", a:L)
endfunction
command! -bang -nargs=1 -complete=custom,ArgCompletion SageLink :lua require("sage.cli").handle("l", "<args>")
command! -bang -nargs=1 -complete=custom,ArgCompletion SageLinkRange :lua require("sage.cli").handle("l", "<args>")

