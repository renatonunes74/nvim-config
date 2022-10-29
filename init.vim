call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'neovim/nvim-lspconfig'
Plug 'andreypopp/vim-colors-plain'
Plug 'sainnhe/sonokai'
Plug 'habamax/vim-colors-lessthan'
Plug 'elsuizo/monosvkem'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'easymotion/vim-easymotion'
"Plug 'ms-jpq/coq_nvim'
"Plug 'ms-jpq/coq.artifacts'
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
set completeopt=menu,menuone,noselect

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
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
