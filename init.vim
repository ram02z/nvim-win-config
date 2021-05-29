set nocompatible
call plug#begin()

Plug 'machakann/vim-sandwich'

Plug 'nacro90/numb.nvim'

Plug 'monaqa/dial.nvim'

Plug 'b0o/vim-shot-f'

call plug#end()


let mapleader = "\<Space>"

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    elseif has('wsl')
	let g:os = "WSL"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if g:os == "Windows"
	let s:clip = 'C:\Windows\System32\clip.exe'
elseif g:os == "WSL"
	let s:clip = '/mnt/c/Windows/System32/clip.exe'
elseif g:os == "Linux"
	" Assumes x11
	let s:clip = 'xclip'
elseif g:os == "Darwin"
	let s:clip = 'pbcopy'
endif

if executable(s:clip)
	augroup Yank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
end

" Normal/Insert mode are set as custom binds
vnoremap <silent> <A-j> :m '>+1<CR>==gv
vnoremap <silent> <A-k> :m '<-2<CR>==gv

"Swap two lines
if exists('g:vscode')
	filetype off
	" disables continuing comments
	au FileType * setlocal formatoptions-=cro

	" Buffer manipulation
	nmap <silent> <Leader>, :tabp<CR>
	nmap <silent> <Leader>. :tabn<CR>
	nmap <silent> <Leader>q :tabc!<CR>
	" Tab moving not supported yet
	" nnoremap <silent> <Leader>> :BufferMoveNext<CR>
	" nnoremap <silent> <Leader>< :BufferMovePrevious<CR>

	" Find in files under cursor
	nnoremap <silent> ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

	" vim-sandwich
	highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
	highlight OperatorSandwichDelete guibg='#ff5555' gui=none ctermbg='red' cterm=none
	highlight OperatorSandwichChange guifg='#F8D97C' gui=underline ctermfg='yellow' cterm=underline
	highlight OperatorSandwichAdd guibg='#50fa7b' gui=none ctermbg='green' cterm=none

	" Vim quickscope
	" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	" highlight QuickScopePrimary guifg='#ff007c' gui=underline ctermfg=155 cterm=underline
	" highlight QuickScopeSecondary guifg='#2b8db3' gui=underline ctermfg=81 cterm=underline

	let g:shot_f_highlight_graph = "guifg='#ff007c' guibg=NONE gui=bold ctermfg=155 cterm=NONE"
	let g:shot_f_highlight_blank = "ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE"
	" Comments
	xmap <C-/> <Plug>VSCodeCommentarygv
	nmap <C-/> <Plug>VSCodeCommentaryLine

	nmap <C-a> <Plug>(dial-increment)
	vmap <C-a> <Plug>(dial-increment)
	nmap <C-x> <Plug>(dial-decrement)
	vmap <C-x> <Plug>(dial-decrement)
	vmap g<C-a> <Plug>(dial-increment-additional)
	vmap g<C-x> <Plug>(dial-decrement-additional)

endif

lua require('numb').setup()

