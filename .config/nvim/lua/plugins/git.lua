return {
  -- Git 修改提示
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- 导航
        map("n", "]h", gs.next_hunk, "下一个 Git 修改")
        map("n", "[h", gs.prev_hunk, "上一个 Git 修改")

        -- 操作
        map("n", "<leader>ghs", gs.stage_hunk, "暂存修改块")
        map("n", "<leader>ghr", gs.reset_hunk, "重置修改块")
        map("v", "<leader>ghs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, "暂存选中块")
        map("v", "<leader>ghr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, "重置选中块")
        map("n", "<leader>ghS", gs.stage_buffer, "暂存所有修改")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "撤销暂存块")
        map("n", "<leader>ghR", gs.reset_buffer, "重置所有修改")
        map("n", "<leader>ghp", gs.preview_hunk, "预览修改")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Git blame")
        map("n", "<leader>ghd", gs.diffthis, "Git diff")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Git diff ~")

        -- 文本对象
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns 选择修改块")
      end,
      current_line_blame = true, -- 显示当前行的 blame 信息
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
      },
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
      },
    },
  },

  -- Git 命令包装
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git 状态" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gl", "<cmd>Git log<cr>", desc = "Git 日志" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gr", "<cmd>Git rebase -i HEAD~", desc = "Git rebase" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git write (add)" },
      { "<leader>gB", "<cmd>GBrowse<cr>", desc = "Git browse" },
    },
  },

  -- 浮动窗口中显示 git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = {
      enabled = false,  -- 默认不启用，使用时手动开启
      date_format = "%Y/%m/%d",
      message_template = "  提交者: <author> • <date> • <summary>",
      message_when_not_committed = "  尚未提交",
      highlight_group = "Comment",
      set_extmark_options = {
        priority = 1000,
      },
    },
  },

  -- 显示 git 冲突标记
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    opts = {
      default_mappings = true,    -- 启用默认快捷键
      default_commands = true,    -- 启用默认命令
      disable_diagnostics = false, -- 启用诊断
      list_opener = 'open_fn',    -- 自定义打开列表的函数
      highlights = {              -- 自定义高亮颜色
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
  },

  -- Git 工作树管理
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      { "<leader>gwc", function() require("git-worktree").create_worktree(vim.fn.input("工作树路径: "), vim.fn.input("分支: ")) end, desc = "创建工作树" },
      { "<leader>gws", function() require("git-worktree").switch_worktree(vim.fn.input("工作树: ")) end, desc = "切换工作树" },
      { "<leader>gwd", function() require("git-worktree").delete_worktree(vim.fn.input("工作树: ")) end, desc = "删除工作树" },
    },
    opts = {},
  },

  -- 浮动窗口显示 lazygit
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit 文件历史" },
      { "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "LazyGit 配置" },
    },
    opts = {
      floating_window_winblend = 0,
      floating_window_scaling_factor = 0.9,
      floating_window_corner_chars = {'╭', '╮', '╰', '╯'},
      lazygit_use_neovim_remote = false,
    },
  },

  -- Telescope Git 集成
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-g>"] = function() 
              local builtin = require("telescope.builtin")
              builtin.git_status()
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
    },
  },
} 