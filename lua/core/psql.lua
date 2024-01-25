local status_ok, psql = pcall(require, "psql")
if not status_ok then
	return
end


local psql = require("psql")
psql.setup({
  database_name = 'dvdrental',
})
