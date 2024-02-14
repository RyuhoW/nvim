local status_ok, template = pcall(require, "template")
if not status_ok then
  return
end

template.setup({
  temp_dir = "~/.config/nvim/lua/core/templates"
})
