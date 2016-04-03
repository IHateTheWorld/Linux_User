set nu
set wrap

set history=1000000

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set cindent

colo evening

set nobackup
set noswapfile

set mouse=a
map <F6> :call CR()<CR>
func! CR()
exec "w"
exec "!g++ % -o %<"
exec "!./%<"
"exec "!rm ./%<"
endfunc

imap <c-]> {<cr>}<c-o>O<left><right>
map <F2> :call SetTitle()<CR>

func SetTitle()
let l = 0
let l = l + 1 | call setline(l,'/*************************************')
let l = l + 1 | call setline(l,'*                                    *')
let l = l + 1 | call setline(l,'*    Auther xxxxxx                   *')
let l = l + 1 | call setline(l,'*    E-mail xxxxxxxxxx@xxx.xxx.com   *')
let l = l + 1 | call setline(l,'*                                    *')
let l = l + 1 | call setline(l,'*************************************/')
let l = l + 1 | call setline(l,'#include <cstdio>')
let l = l + 1 | call setline(l,'using namespace std;')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'int main()')
let l = l + 1 | call setline(l,'{')
let l = l + 1 | call setline(l,'    return 0;')
let l = l + 1 | call setline(l,'}')
endfunc

