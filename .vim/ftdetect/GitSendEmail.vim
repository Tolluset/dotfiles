" vim ftdetect file
" Filename:     GitSendEmail.vim
" Language:     git send-email --compose
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.11
" License:      New BSD License
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

autocmd BufRead .msg.* :setfiletype mail
