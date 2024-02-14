local status_ok, plantuml = pcall(require, "plantuml")
if not status_ok then
  return
end


plantuml.setup({
})
