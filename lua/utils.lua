-- Keymap functions

local M = {}

function M.map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true })
end

function M.noremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

function M.exprnoremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true, expr = true })
end

-- Useful mode-specific shortcuts
-- nomenclature: "<expr?><mode><nore?>map(lhs, rhs)" where:
--      "expr?" optional expr option
--      "nore?" optional no-remap option
--      modes -> 'n' = NORMAL, 'i' = INSERT, 'x' = 'VISUAL', 'v' = VISUAL + SELECT, 't' = TERMINAL

function M.nmap(lhs, rhs)
  M.map("n", lhs, rhs)
end

function M.xmap(lhs, rhs)
  M.map("x", lhs, rhs)
end

function M.nnoremap(lhs, rhs)
  M.noremap("n", lhs, rhs)
end

function M.vnoremap(lhs, rhs)
  M.noremap("v", lhs, rhs)
end

function M.xnoremap(lhs, rhs)
  M.noremap("x", lhs, rhs)
end

function M.inoremap(lhs, rhs)
  M.noremap("i", lhs, rhs)
end

function M.tnoremap(lhs, rhs)
  M.noremap("t", lhs, rhs)
end

function M.exprnnoremap(lhs, rhs)
  M.exprnoremap("n", lhs, rhs)
end

function M.exprinoremap(lhs, rhs)
  M.exprnoremap("i", lhs, rhs)
end

function M.hslToRgb(h, s, l)
  if s == 0 then return l, l, l end
  local function to(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < .16667 then return p + (q - p) * 6 * t end
    if t < .5 then return q end
    if t < .66667 then return p + (q - p) * (.66667 - t) * 6 end
    return p
  end
  local q = l < .5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return math.floor(to(p, q, h + .33334) * 255), math.floor(to(p, q, h) * 255), math.floor(to(p, q, h - .33334) * 255)
end

function M.rgbToHsl(r, g, b)
  r, b, g = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  b = max + min
  local h = b / 2
  if max == min then return 0, 0, h end
  local s, l = h, h
  local d = max - min
  s = l > .5 and d / (2 - b) or d / b
  if max == r then
    h = (g - b) / d + (g < b and 6 or 0)
  elseif max == g then
    h = (b - r) / d + 2
  elseif max == b then
    h = (r - g) / d + 4
  end
  return h * .16667, s, l
end

function M.hexToRgb(hex_color)
  if string.find(hex_color, "^#") then
    hex_color = string.sub(hex_color, 2)
  end

  local base16 = tonumber(hex_color, 16)
  return math.floor(base16 / 0x10000), (math.floor(base16 / 0x100) % 0x100), (base16 % 0x100)
end

function M.rgbToHex(r, g, b)
  local clamp = function(component)
    return math.min(math.max(component, 0), 255)
  end
  return string.format("#%06x", clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b))
end

return M
