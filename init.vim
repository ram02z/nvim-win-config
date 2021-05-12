call plug#begin()

Plug 'machakann/vim-sandwich'

Plug 'unblevable/quick-scope'

Plug 'nacro90/numb.nvim'

Plug 'monaqa/dial.nvim'

call plug#end()

let mapleader = "\<Space>"

set clipboard+=unnamedplus

set autoindent

nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc> :m .+1<CR>==gi
inoremap <silent> <A-k> <Esc> :m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>==gv
vnoremap <silent> <A-k> :m '<-2<CR>==gv

"Swap two lines
if exists('g:vscode')
	" Buffer manipulation
	nmap <silent> <Leader>, :tabp<CR>
	nmap <silent> <Leader>. :tabn<CR>
	nmap <silent> <Leader>q :tabc!<CR>
	" Tab moving not supported yet
	" nnoremap <silent> <Leader>> :BufferMoveNext<CR>
	" nnoremap <silent> <Leader>< :BufferMovePrevious<CR>

	" Find in files under cursor
	nnoremap <silent> ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

	" Open defintion aside
	nnoremap <silent> <C-w>gd <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

	" vim-sandwich
	highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
	highlight OperatorSandwichChange guifg='#F8D97C' gui=underline ctermfg='yellow' cterm=underline
	highlight OperatorSandwichAdd guibg='#50fa7b' gui=none ctermbg='green' cterm=none
	highlight OperatorSandwichDelete guibg='#ff5555' gui=none ctermbg='red' cterm=none

	" Vim quickscope
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	highlight QuickScopePrimary guifg='#ff007c' gui=underline ctermfg=155 cterm=underline
	highlight QuickScopeSecondary guifg='#2b8db3' gui=underline ctermfg=81 cterm=underline

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
