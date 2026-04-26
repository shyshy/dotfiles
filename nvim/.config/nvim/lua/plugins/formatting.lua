return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local util = require("conform.util")

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = {
        command = util.find_executable({ "node_modules/.bin/oxfmt" }, "oxfmt"),
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
        cwd = util.root_file({ ".oxfmtrc.json" }),
        require_cwd = true,
      }

      local function buf_dir(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name == "" then
          return nil
        end
        return vim.fs.dirname(name)
      end

      local function has_ancestor(bufnr, names)
        local dir = buf_dir(bufnr)
        if not dir then
          return false
        end
        return vim.fs.find(names, { upward = true, path = dir, stop = vim.env.HOME })[1] ~= nil
      end

      local function has_prettier_in_pkg(bufnr)
        local dir = buf_dir(bufnr)
        if not dir then
          return false
        end
        local pkg = vim.fs.find({ "package.json" }, { upward = true, path = dir, stop = vim.env.HOME })[1]
        if not pkg then
          return false
        end
        local ok, lines = pcall(vim.fn.readfile, pkg)
        if not ok then
          return false
        end
        return table.concat(lines, "\n"):match('"prettier"%s*:') ~= nil
      end

      local prettier_markers = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      }

      local function pick(bufnr)
        bufnr = bufnr or 0
        if has_ancestor(bufnr, { ".oxfmtrc.json" }) then
          return { "oxfmt" }
        end
        if has_ancestor(bufnr, prettier_markers) or has_prettier_in_pkg(bufnr) then
          return { "prettier" }
        end
        return {}
      end

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "css",
        "scss",
        "html",
        "graphql",
        "vue",
      }
      for _, ft in ipairs(filetypes) do
        opts.formatters_by_ft[ft] = pick
      end

      return opts
    end,
  },
}
