call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'neovim/nvim-lspconfig'
Plug 'sainnhe/sonokai'
Plug 'habamax/vim-colors-lessthan'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'metakirby5/codi.vim'
call plug#end()

lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.ccls.setup{}

"archives
filetype plugin on
syntax on
set relativenumber
set title
set ai
set shiftwidth=4
set smartindent
set ts=4
map q :x<CR><CR>

"spell
map <F6> :setlocal spell! spell_language=pt,en_us<CR>
let spell_language_list = "brasileiro, americano, castellano"
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR><CR>

"menu
set completeopt=menu,menuone,noselect,noinsert

set list

let mapleader=" "

"colors
colorscheme lessthan 
hi LineNr ctermfg=236
hi Search ctermbg=233 ctermfg=12

"lsp
nnoremap <leader>vd :lua vim.lsp.buf.declaration<CR>


"explore
nnoremap <leader>pv :Ex<CR>

"harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <c-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <c-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <c-t> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <c-n> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <c-s> :lua require("harpoon.ui").nav_file(4)<CR>

"FZF
function! FZF() abort
	let l:tempname = tempname()
	" fzf | awk '{ print $1":1:0" }' > file
	execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
	try
		execute 'cfile' . l:tempname
		redraw!
	finally
		call delete(l:tempname)
	endtry
endfunction
" :Files
command! -nargs=* Files call FZF()
"FZF
nnoremap <leader>f :split<cr>:FZF<Enter>
nnoremap <leader>F :split<cr>:FZF<Enter>

"coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
