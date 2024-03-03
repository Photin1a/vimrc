" request:
"   1. nodejs>=14
"   2. npm
"   3. python3 (pip3 install neovim)
imap jk <Esc>
nmap <space> :

" Clipboard  System Clipboard
set clipboard^=unnamed,unnamedplus

set number
set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ignorecase
set smartcase
set notimeout
set mouse=a
set backspace=2

let mapleader = "\<SPACE>" " defualt ,

" =======================
" ===  plugins  begin ===
" =======================
call plug#begin('~/.vim/plugged')
  
  " enhance edito  注释的快捷键
  Plug 'tomtom/tcomment_vim' 
  
  " terminal
  Plug 'skywind3000/vim-terminal-help'
  
  " file explorer
  Plug 'preservim/nerdtree'

  " file finder
  " highlight
  Plug 'cateduo/vsdark.nvim'
  Plug 'tomasiser/vim-code-dark'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  
  " lsp
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  
  " debug
  Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-rust --enable-python'}
  
call plug#end()
" =======================
" ===   plugins  end  ===
" ======================
"
" ==== terminal ====
" ALT + =: toggle terminal below.
" ALT + SHIFT + h: move to the window on the left.
" ALT + SHIFT + l: move to the window on the right.
" ALT + SHIFT + j: move to the window below.
" ALT + SHIFT + k: move to the window above.
" ALT + SHIFT + n: move to the previous window.
" ALT + -: paste register 0 to terminal.
" ALT + q: switch to terminal normal mode.

" ==== tomtom/tcomment_vim ====
"" 取消注释：ctrl+//
"" 注释    ：ctrl+//
" let g:tcomment_textobject_inlinecomment = ''
nmap <C-/> g>c  
vmap <C-/> g>
nmap <C-/> g<c  
vmap <C-/> g<

let g:tcomment_mapleader2 = ''
" ==== preservim/nerdtree ====
map <silent> <C-e> :NERDTreeToggle<CR>
" map <silent> <C-w> :NERDTreeFind<CR>
" nmap <leader>nt :NERDTreeFind<CR>

" ==== Yg:gdroot/LeaderF ====
let g:Lf_WindowPosition='right'
let g:Lf_PreviewInPopup=1
let g:Lf_CommandMap = {
\   '<C-p>': ['<C-k>'],
\   '<C-k>': ['<C-p>'],
\   '<C-j>': ['<C-n>']
\}
nmap <leader>f :Leaderf file<CR>
nmap <leader>b :Leaderf! buffer<CR>
nmap <leader>F :Leaderf rg<CR>
let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"

" ==== cateduo/vsdark.nvim ====
"set termguicolors
"let g:vsdark_style = "dark"
"colorscheme vsdark

" ==== code dark ====
set background=dark
try
  set t_Co=256
  set t_ut=
  colorscheme codedark
catch
  try

    colorscheme desert
  catch
    colorscheme peaksea
  endtry
  endtry



" ==== jackguo380/vim-lsp-cxx-highlight ====
hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias

" ==== neoclide/coc.nvim ====
" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-vimlsp',
      \ 'coc-cmake',
      \ 'coc-highlight',
      \ 'coc-pyright'
      \ ]

set signcolumn=number
" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <s-TAB> to select candidate backward
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight link CocHighlightText Visual
" autocmd CursorHold * silent call CocActionAsync('highlight')   " TODO

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" diagnostic info
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" statusline support
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()

" ==== puremourning/vimspector ====
let g:vimspector_enable_mappings = 'HUMAN'

"function! s:generate_vimspector_conf()
"  if empty(glob( '.vimspector.json' ))
"    if &filetype == 'c' || 'cpp' 
"      !cp ~/.config/nvim/vimspector_conf/c.json ./.vimspector.json
"    elseif &filetype == 'python'
"      !cp ~/.config/nvim/vimspector_conf/python.json ./.vimspector.json
"    endif
"  endif
"  e .vimspector.json
"endfunction
"
"command! -nargs=0 Gvimspector :call s:generate_vimspector_conf()

nmap <Leader>v <Plug>VimspectorBalloonEval
xmap <Leader>v <Plug>vimspectorBalloonEval

