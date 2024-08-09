local uname = vim.loop.os_uname()
_G.OS = uname.sysname
_G.IS_MAC = OS == "Darwin"
_G.IS_LINUX = OS == "Linux"
_G.IS_WINDOWS = OS:find("Windows") and true or false
_G.IS_WSL = IS_LINUX and uname.release:find("Microsoft") and true or false

vim.opt.termguicolors = true
require("_lazy")
require("options")
require("keybinds")
