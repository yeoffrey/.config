local cmd = ". ~/tailwind/cloudflare-login.sh && clear && pi"
local reload_timer ---@type uv.uv_timer_t?

local function stop_buffer_reload()
  if reload_timer then
    reload_timer:stop()
    reload_timer:close()
    reload_timer = nil
  end
end

local function start_buffer_reload(buf)
  if reload_timer then
    return
  end

  vim.opt.autoread = true
  reload_timer = vim.uv.new_timer()
  reload_timer:start(
    800,
    800,
    vim.schedule_wrap(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        stop_buffer_reload()
        return
      end
      vim.cmd("silent! checktime")
    end)
  )
end

local function pi_opts()
  return {
    cwd = LazyVim.root(),
    count = 1,
    win = {
      position = "right",
      width = 0.4,
      on_buf = function(self)
        start_buffer_reload(self.buf)
        vim.api.nvim_create_autocmd("BufWipeout", {
          buffer = self.buf,
          once = true,
          callback = stop_buffer_reload,
        })
      end,
    },
  }
end

local function selected_text()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local lines = vim.fn.getregion(start_pos, end_pos, { type = mode })
    local start_line = math.min(start_pos[2], end_pos[2])
    local end_line = math.max(start_pos[2], end_pos[2])
    return table.concat(lines, "\n"), start_line, end_line
  end

  local line = vim.fn.line(".")
  return vim.api.nvim_get_current_line(), line, line
end

local function format_selection(text, start_line, end_line)
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  if path == "" then
    path = "[No Name]"
  end

  local location
  if start_line == end_line then
    location = string.format("%s:%d", path, start_line)
  else
    location = string.format("%s:%d-%d", path, start_line, end_line)
  end

  local ft = vim.bo.filetype
  local fence = ft ~= "" and ft or ""
  return string.format("\n```%s\n%s\n%s\n```\n", fence, location, text)
end

local function current_buffer_link()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return nil
  end

  local root = vim.fs.normalize(LazyVim.root())
  name = vim.fs.normalize(name)
  if vim.startswith(name, root .. "/") then
    name = name:sub(#root + 2)
  else
    name = vim.fn.fnamemodify(name, ":.")
  end

  return "@" .. name
end

local function send_to_pi(text)
  local term, created = Snacks.terminal.get(cmd, pi_opts())
  if not term or not term:buf_valid() then
    vim.notify("Pi terminal is not available", vim.log.levels.WARN)
    return
  end

  local function paste()
    local job_id = vim.b[term.buf].terminal_job_id
    if not job_id then
      vim.notify("Pi terminal job is missing", vim.log.levels.WARN)
      return
    end

    -- Bracketed paste inserts into Pi's prompt without submitting it.
    vim.api.nvim_chan_send(job_id, "\27[200~" .. text .. "\27[201~")
    term:show()
    term:focus()
  end

  if created then
    vim.defer_fn(paste, 400)
  else
    paste()
  end
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>ao",
      function()
        Snacks.terminal.toggle(cmd, pi_opts())
      end,
      desc = "Pi (side window)",
    },
    {
      "<leader>as",
      function()
        local text, start_line, end_line = selected_text()
        if vim.trim(text) == "" then
          vim.notify("Nothing selected to send to Pi", vim.log.levels.WARN)
          return
        end
        send_to_pi(format_selection(text, start_line, end_line))
      end,
      mode = { "n", "v" },
      desc = "Send selection to Pi",
    },
    {
      "<leader>ab",
      function()
        local link = current_buffer_link()
        if not link then
          vim.notify("Current buffer has no file path", vim.log.levels.WARN)
          return
        end
        send_to_pi(link .. " ")
      end,
      desc = "Link current buffer in Pi",
    },
  },
}
