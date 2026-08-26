local api = vim.api

local function plugin_path(name, ev)
  if ev and ev.data and ev.data.path then
    return ev.data.path
  end
  return vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name
end

local function run_build(ev)
  local spec = ev.data and ev.data.spec or {}
  local build = (spec.data or {}).build
  if type(build) ~= "table" or #build == 0 then
    return
  end

  local cwd = plugin_path(spec.name, ev)
  if not vim.uv.fs_stat(cwd) then
    return
  end

  if vim.system then
    vim.system(build, { cwd = cwd, text = true }, function(res)
      if res.code ~= 0 then
        vim.schedule(function()
          vim.notify("vim.pack build failed for " .. spec.name, vim.log.levels.WARN)
        end)
      end
    end)
  else
    vim.fn.system(build)
  end
end

api.nvim_create_autocmd("PackChanged", {
  desc = "vim.pack hooks for post-install/update steps",
  callback = function(ev)
    local name = ev.data and ev.data.spec and ev.data.spec.name or nil
    local kind = ev.data and ev.data.kind or nil

    if kind == "install" or kind == "update" then
      run_build(ev)
    end

    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      pcall(vim.cmd, "TSUpdate")
    end
  end,
})
