local Terminal  = require('toggleterm.terminal').Terminal
local venv_term = Terminal:new({
  cmd = "/bin/zsh -c 'export VIRTUAL_ENV_DISABLE_PROMPT=1; source /root/venv/bin/activate; exec zsh -l'",  
  hidden = true,
})

function _VenvToggle()
  venv_term:toggle()
end

vim.keymap.set("n", "<M-i>", _VenvToggle, { noremap = true, silent = true })
