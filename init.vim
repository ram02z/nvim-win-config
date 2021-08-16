set nocompatible
call plug#begin()

Plug 'machakann/vim-sandwich'

Plug 'nacro90/numb.nvim'

Plug 'monaqa/dial.nvim'

Plug 'rhysd/clever-f.vim'

call plug#end()

let mapleader = "\<Space>"

map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
nmap <Esc> <Plug>(clever-f-reset)<cmd>noh<CR>

let g:clever_f_smart_case = 1
let g:clever_f_chars_match_any_signs = ';'
let g:clever_f_fix_key_direction = 1
let g:clever_f_mark_direct = 1
highlight CleverFDefaultLabel guifg='#ff007c' guibg=NONE gui=bold ctermfg=162 cterm=NONE

runtime macros/sandwich/keymap/surround.vim

au! CmdlineEnter * ++once lua require("numb").setup()

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
	highlight OperatorSandwichDelete guibg='#ff5555' gui=none ctermbg=red cterm=none
	highlight OperatorSandwichChange guifg='#F8D97C' gui=underline ctermfg=yellow cterm=underline
	highlight OperatorSandwichAdd guibg='#50fa7b' gui=none ctermbg=green cterm=none

	let g:shot_f_highlight_graph = "guifg='#ff007c' guibg=NONE gui=bold ctermfg=155 cterm=NONE"
	let g:shot_f_highlight_blank = "ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE"
	" Comments
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
	" Increment/decrement
	nmap <C-a> <Plug>(dial-increment)
	vmap <C-a> <Plug>(dial-increment)
	nmap <C-x> <Plug>(dial-decrement)
	vmap <C-x> <Plug>(dial-decrement)
	vmap g<C-a> <Plug>(dial-increment-additional)
	vmap g<C-x> <Plug>(dial-decrement-additional)
else
	set mouse=a
	set termguicolors
endif

