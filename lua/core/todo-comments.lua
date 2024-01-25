local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
  return
end

todo_comments.setup {}

local vim = vim.api

function perf()
  local pos = vim.nvim_win_get_cursor(0)[2]
  local line = vim.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'PERF:' .. line:sub(pos + 1)
  vim.nvim_set_current_line(nline)
end

function hack()
  local pos = vim.nvim_win_get_cursor(0)[2]
  local line = vim.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'HACK:' .. line:sub(pos + 1)
  vim.nvim_set_current_line(nline)
end

function todo()
  local pos = vim.nvim_win_get_cursor(0)[2]
  local line = vim.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'TODO:' .. line:sub(pos + 1)
  vim.nvim_set_current_line(nline)
end

function fix()
  local pos = vim.nvim_win_get_cursor(0)[2]
  local line = vim.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'FIX:' .. line:sub(pos + 1)
  vim.nvim_set_current_line(nline)
end

function warning()
  local pos = vim.nvim_win_get_cursor(0)[2]
  local line = vim.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'WARNING:' .. line:sub(pos + 1)
  vim.nvim_set_current_line(nline)
end
