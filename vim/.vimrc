call plug#begin('~/.vim/plugged')

" add copilot plugin
Plug 'github/copilot.vim'
" add C# pulgin
Plug 'OmniSharp/omnisharp-vim'
" add python plugin
Plug 'davidhalter/jedi-vim'
" add markdown plugin
Plug 'plasticboy/vim-markdown'
" add fern file explorer plugin
Plug 'lambdalisue/fern.vim'
" add fern renderer for nerd font
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" add fern git status plugin
Plug 'lambdalisue/fern-git-status.vim'
" add fern hijack plugin
Plug 'lambdalisue/fern-hijack.vim'
" add nerd font plugin
Plug 'lambdalisue/nerdfont.vim'
" add glyph palette plugin
Plug 'lambdalisue/glyph-palette.vim'

call plug#end()

" General settings
set encoding=utf-8      " Set encoding to UTF-8
set number              " Show line numbers
set tabstop=4           " Number of spaces that a <Tab> counts for
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent
set expandtab           " Use spaces instead of tabs
set smartindent         " Smart autoindenting on new lines
set clipboard=unnamedplus " Use system clipboard

inoremap jj <Esc>


" Enable Copilot
inoremap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
inoremap <silent> <C-l> <Plug>(copilot-next)
inoremap <silent> <C-h> <Plug>(copilot-previous)
inoremap <silent> <C-\\> <Plug>(copilot-suggest)

let g:copilot_filetypes = {'*': v:true}

" OmniSharp settings for C#
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_highlight_variables = 1
let g:OmniSharp_highlight_methods = 1
let g:OmniSharp_highlight_fields = 1
let g:OmniSharp_highlight_properties = 1
let g:OmniSharp_highlight_events = 1
let g:OmniSharp_highlight_namespaces = 1
let g:OmniSharp_highlight_keywords = 1
let g:OmniSharp_highlight_strings = 1
let g:OmniSharp_highlight_numbers = 1
let g:OmniSharp_highlight_comments = 1
let g:OmniSharp_highlight_text = 1  

" Mapping for OmniSharp
nnoremap <leader>oi :OmniSharp<CR>
nnoremap <leader>or :OmniSharpRestartServer<CR>
nnoremap <leader>og :OmniSharpGotoDefinition<CR>
nnoremap <leader>of :OmniSharpFindImplementations<CR>
nnoremap <leader>om :OmniSharpFindMembers<CR>
nnoremap <leader>os :OmniSharpFindSymbols<CR>
nnoremap <leader>oc :OmniSharpCodeFormat<CR>
nnoremap <leader>ot :OmniSharpTypeLookup<CR>
nnoremap <leader>ow :OmniSharpShowLastError<CR>
nnoremap <leader>ol :OmniSharpShowQuickFixes<CR> 
nnoremap <leader>od :OmniSharpDocumentFormat<CR>


" ---------- Fern: سوییچ/بازکردن سایدبار ----------
" <leader>e => باز/بستن در حالت Drawer (سایدبار) با عرض 30 ستون
nnoremap <silent> <leader>e :Fern . -drawer -toggle -width=30<CR>

" <leader>E => بازکردن و فوکوس روی فایل/بافر فعلی در درخت (follow current)
nnoremap <silent> <leader>E :Fern . -drawer -reveal=% -width=30<CR>

" renderer آیکونی
let g:fern#renderer = 'nerdfont'

" مخفی‌ها (dotfiles) را پیش‌فرض نشان نده؛ با نقطه عوض کن
let g:fern#default_hidden = 0

" وضعیت گیت
let g:fern_git_status#disable_ignored = 1  " آیتم‌های ignore شده را نادیده بگیر

" ---------- رنگ‌آمیزی آیکون‌ها ----------
augroup my_glyph_palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" ---------- مپینگ‌های کاربردی داخل پنجره‌ی fern ----------
function! s:fern_init() abort
  " باز کردن
  nnoremap <buffer> o    <Plug>(fern-action-open)
  nnoremap <buffer> s    <Plug>(fern-action-open:split)
  nnoremap <buffer> v    <Plug>(fern-action-open:vsplit)
  nnoremap <buffer> t    <Plug>(fern-action-open:tabedit)

  " mange
  nnoremap <buffer> r    <Plug>(fern-action-reload)
  nnoremap <buffer> R    <Plug>(fern-action-rename)
  nnoremap <buffer> N    <Plug>(fern-action-new-file)
  nnoremap <buffer> D    <Plug>(fern-action-new-dir)
  nnoremap <buffer> d    <Plug>(fern-action-remove)
  nnoremap <buffer> m    <Plug>(fern-action-move)
  nnoremap <buffer> .    <Plug>(fern-action-hidden-toggle) " نمایش/مخفی کردن dotfiles

  " کپی/یَنک مسیر
  nnoremap <buffer> C    <Plug>(fern-action-copy)
  nnoremap <buffer> Y    <Plug>(fern-action-yank)

  " خروج از سایدبار
  nnoremap <buffer> q    :q<CR>
endfunction
autocmd FileType fern call s:fern_init()
