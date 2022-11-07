local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

local function get_arduino_fqbn(inputstr)

  local t = {}
  for str in string.gmatch(inputstr, "([^:]+)") do
    table.insert(t, str)
  end
local s = table.concat(t, ":", 1, 3)

  return s

end

local arduino_board_fqbn = get_arduino_fqbn(vim.g.arduino_board)

local function arduino_status()
  local ft = vim.api.nvim_buf_get_option(0, "ft")
  if ft ~= "arduino" then
    return ""
  end
  local port = vim.fn["arduino#GetPort"]()
  local line = string.format("[%s]", arduino_board_fqbn)
  if vim.g.arduino_programmer ~= "" then
    line = line .. string.format(" [%s]", vim.g.arduino_programmer)
  end
  if port ~= 0 then
    line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
  end
  return line
end

local arduino_opts = {
  cmd = {
    "/usr/bin/arduino-language-server",
    "-clangd", "/home/paulo/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd",
    "-cli", "/usr/bin/arduino-cli",
    "-cli-config", "/home/paulo/.arduino15/arduino-cli.yaml",
    "-fqbn", arduino_board_fqbn
  }
}

opts = vim.tbl_deep_extend("force", arduino_opts, opts)
lspconfig["arduino_language_server"].setup(opts)

--local lualine = require('lualine').get_config()
--
--lualine.setup {
--  sections = {
--    lualine_z = { arduino_status },
--  },
--}
--
--require('lualine').setup(lualine)

--require("lspconfig")["arduino_language_server"].setup(opts)

--  local config = lualine.get_config()

--lvim.builtin.lualine.sections.lualine_c = { arduino_status }
