return {
  cmd = {
    "arduino-language-server",
    "-clangd", "/home/paulo/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd",
    "-cli", "/usr/bin/arduino-cli",
    "-cli-config", "/home/paulo/.arduino15/arduino-cli.yaml",
    "-fqbn",
    "arduino:avr:uno"
  },
}
