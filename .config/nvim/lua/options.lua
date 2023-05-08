-- options
vim.opt.syntax='on'
vim.opt.termguicolors=true
vim.cmd[[silent! colorscheme dracula]]
vim.opt.encoding='utf-8'
vim.opt.fileencodings='utf-8'
vim.opt.ttyfast=true
vim.opt.backspace='indent,eol,start'
vim.opt.tabstop=2
vim.opt.softtabstop=0
vim.opt.shiftwidth=2
vim.opt.expandtab=true
vim.g.mapleader=','
vim.opt.hidden=true
vim.opt.hlsearch=true
vim.opt.incsearch=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.number=true
vim.opt.showcmd=true
vim.opt.ruler=true
vim.opt.modeline=false
vim.opt.modelines=10
vim.opt.title=false
vim.opt.titleold="Terminal"
vim.opt.titlestring='%F'
vim.opt.belloff='all'
vim.opt.mouse=''
vim.cmd[[let &colorcolumn=join(range(81,999),",")]]
vim.cmd[[let &colorcolumn="80,".join(range(400,999),",")]]
vim.cmd[[
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#files('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)
endif
]]
