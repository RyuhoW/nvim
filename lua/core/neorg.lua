local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},  -- Adds pretty icons to your documents
    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          home = "~/notes/home",
        },
        index = "index.norg"
      }
    }
  },
  languages = {
    lua = { template = { annotation_convention = 'emmylua' } },
    python = { template = { annotation_convention = 'numpydoc' } },
  },
})
