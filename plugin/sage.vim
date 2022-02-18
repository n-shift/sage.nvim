function! SageCompletion(A, L, P)
    return luaeval("require('sage.cli').completion(_A)", a:L)
endfunction
function! SageHeadingCompletion(A, L, P)
    return luaeval("require('sage.link.heading').completion()")
endfunction

command! -bang -nargs=1 -complete=custom,SageCompletion SageLink :lua require("sage.cli").handle("l", "<args>")
command! -bang -nargs=1 -complete=custom,SageCompletion SageLinkRange :lua require("sage.cli").handle("l", "<args>")
command! -bang -nargs=0 SageToc :lua require("sage.toc")()
