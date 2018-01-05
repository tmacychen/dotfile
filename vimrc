""vimrc by Tmacy
set nocompatible                "去掉关于vi一致性的模式


syntax on
filetype plugin indent on
set cul                         "高亮光标所在行 
""color ron                      "设置主题
""color molokai
color desert 
""colorscheme vividchalk
set showcmd                     "显示Normal模式下按键命令
set number
set numberwidth=3               
set nowrap                      "不要让排版适应单词，在换行出插入换行符(Insert)
set textwidth=0                 "同上（View)

"状态行显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}  
set laststatus=2                "启动显示状态行(1),总是显示状态行(2)

set wildmenu                     "增强命令补全 
set wildmode=list:longest,full
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=
set selection=exclusive
set selectmode=mouse,key

set foldenable                   "设置是否可以折叠
set foldmethod=marker            "作为标记折叠
set noerrorbells                 " do not use error bell
set novisualbell                 " do not use visual bell
set t_vb=                        " do not use terminal bell
set ignorecase                   "搜索时忽略大小写

set wildignore=.git,.*.swp,*.bak,*~,*.o,*.a "tab忽略这些文件
set autowrite
set autoread
set history=100                         "最近使用过的命令行历史记录
set backspace=indent,eol,start          "backspace can delete everything
set completeopt=menuone,longest         "complete options
set pumheight=10
set scrolloff=5                         "向上移动文档，光标距离边框最小行数
set autoindent
set tabstop=4
set expandtab                       "不要用空格键代替tab
set softtabstop=4                   " insert and delete space of <tab>
set shiftwidth=4
set hlsearch                        " highlight search match
set incsearch                       " incremental search
set smartcase                       " do not ignore if search pattern has CAPS
set smartindent
set nobackup                        " do not create backup file
set noswapfile                      " do not create swap file
set backupcopy=yes                  " overwrite the original file

set encoding=utf-8
set fenc=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312
set fileformat=unix
set langmenu=zh_CN.UTF-8
set helplang=cn

" 在处理未保存或只读文件的时候，弹出确认
set confirm

set background=dark

" gui settings
if has("gui_running")
    set guioptions-=T " no toolbar
    set guioptions-=r " no right-hand scrollbar
    set guioptions-=R " no right-hand vertically scrollbar
    set guioptions-=l " no left-hand scrollbar
    set guioptions-=L " no left-hand vertically scrollbar
    autocmd GUIEnter * simalt ~x " window width and height
    source $VIMRUNTIME/delmenu.vim " the original menubar has an error on win32, so
    source $VIMRUNTIME/menu.vim    " use this menubar
    language messages zh_CN.utf-8 " use chinese messages if has
endif

" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

"""""键盘命令
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" move between windows

map <F3> :NERDTree<CR>  
"列出当前目录文件  

nmap <F8> :TagbarToggle<CR>
"列出变量以及函数"

:nmap <silent> <F9> <ESC>:Tlist<RETURN>
map! <C-Z> <Esc>zzi
"在插入模式下<ctrl-z> 设置当前编辑位置居中并进入插入模式 
map! <C-O> <C-Y>,
"在插入模式下<ctrl-o> 设置为html标签的格式
map <C-A> ggVG$"+y
"全选并复制
map <F12> gg=G

vmap <C-c> "+y
"在可视模式下，复制一段文本
"格式化代码
" map : -> <space>
map <Space> :

"当打开vim且没有文件时自动打开NERDTree
""autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



"markdown ,go 配置 
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go

"""""新文件标题
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py,*.pl exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'perl' 
		call setline(1,"\#!/usr/bin/perl -w") 
		call append(line("."), "use strict;") 
		call append(line(".")+1, "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
		call append(line(".")+1, "") 
"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: chen") 
		call append(line(".")+2, "	> Mail: chen_tmacy@foxmail.com") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
    
"	if &filetype == 'java'
"		call append(line(".")+6,"public class ".expand("%"))
"		call append(line(".")+7,"")
"	endif
	"新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G


"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'go'
        exec "!go fmt %"
    elseif &filetype == 'py'||&filetype == 'python'
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

"将tab替换为空格
nmap tt :%s/\t/    /g<CR>"

"自动补全
:inoremap ( ()<ESC>i
:inoremap { {}<ESC>i
:inoremap [ []<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>


function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
      return "\<Right>"
  else
      return a:char
  endif
endfunction

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
    else
        "Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endf


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'perl'
        exec "!perl % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc



" Tagbar
 let g:tagbar_autofocus = 1
 let g:tagbar_autoclose = 1


