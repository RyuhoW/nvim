local status_ok, template = pcall(require, "template")
if not status_ok then
  return
end

require("telescope").load_extension('find_template')


template.setup({
  temp_dir = "~/.config/nvim/lua/core/templates"
})
