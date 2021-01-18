if !has('gui_running') || (!has('win32') && !has('win64'))
  finish
endif

let s:src_path = expand('<sfile>:p:h:h') . (has('win64') ? '/vimtweak64.dll' : '/vimtweak32.dll')
let s:dest_path = expand(fnamemodify(v:progpath, ':h') .. '/' .. getpid() .. '-' .. (has('win64') ? 'vimtweak64.dll' : 'vimtweak32.dll'), 1)

augroup vimtweak
	autocmd!
	autocmd VimEnter * :silent! call writefile(readfile(s:src_path, 'b'), s:dest_path, 'b')
	autocmd VimLeave * :silent! call delete(s:dest_path)
augroup END

function! s:libcallnr(funcname, arg1) abort
	call libcallnr(s:dest_path, a:funcname, a:arg1)
endfunction

command! -nargs=1 VimTweakSetAlpha call s:libcallnr("SetAlpha", 0+<args>)
command! VimTweakEnableMaximize    call s:libcallnr("EnableMaximize", 1)
command! VimTweakDisableMaximize   call s:libcallnr("EnableMaximize", 0)
command! VimTweakEnableTopMost     call s:libcallnr("EnableTopMost", 1)
command! VimTweakDisableTopMost    call s:libcallnr("EnableTopMost", 0)
command! VimTweakEnableCaption     call s:libcallnr("EnableCaption", 1)
command! VimTweakDisableCaption    call s:libcallnr("EnableCaption", 0)
