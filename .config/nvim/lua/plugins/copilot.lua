return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = false },
      })
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
    },
    -- build = "make tiktoken",
    opts = function()
      local system_prompt = "You are a senior software engineer. Be concise and precise. Prefer idiomatic code."
      local instructions_path = vim.fn.expand("~/.github/copilot-instructions.md")
      if vim.fn.filereadable(instructions_path) == 1 then
        local lines = vim.fn.readfile(instructions_path)
        system_prompt = system_prompt .. "\n\n" .. table.concat(lines, "\n")
      end

      return {
        model = "gpt-4.1",
        debug = false,
        auto_insert_mode = true,
        show_help = false,
        system_prompt = system_prompt,
        context = "buffers",
        window = {
          layout = "vertical",
          width = 0.4,
          border = "rounded",
        },
        headers = {
          user = "   You ",
          assistant = "   Friend",
          tool = "   Tool ",
        },
        prompts = {
          Refactor = {
            prompt =
            "Review the selected code and suggest refactoring to improve readability and maintainability. Focus on DRY and SOLID principles.",
          },
          Concise = {
            prompt = "Rewrite this code to be more concise without sacrificing readability.",
          },
          Naming = {
            prompt = "Suggest better variable and function names for the selected code.",
          },
          TypeCheck = {
            prompt = "Add or improve type annotations for the selected code.",
          },
        },
      }
    end,
    keys = {
      -- Chat
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>",   desc = "[Chat] Toggle", },
      { "<leader>cm", "<cmd>CopilotChatModels<cr>",   desc = "[Chat] Select Model" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>",    desc = "[Chat] Reset" },
      { "<leader>cs", "<cmd>CopilotChatStop<cr>",     desc = "[Chat] Stop Output" },
      -- Debug
      { "<leader>cd", "<cmd>CopilotChatDebug<cr>",    desc = "[Debug] Debug Code",     mode = "v" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>",      desc = "[Debug] Fix Code",       mode = "v" },
      -- Documentation
      { "<leader>cD", "<cmd>CopilotChatDocs<cr>",     desc = "[Docs] Generate Docs",   mode = "v" },
      -- Explain
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>",  desc = "[Explain] Explain Code", mode = "v" },
      -- Refactor
      { "<leader>cR", "<cmd>CopilotChatRefactor<cr>", desc = "[Refactor] Refactor",    mode = "v" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "[Refactor] Optimize",    mode = "v" },
      { "<leader>cv", "<cmd>CopilotChatReview<cr>",   desc = "[Refactor] Review",      mode = "v" },
      -- Tests
      { "<leader>ct", "<cmd>CopilotChatTests<cr>",    desc = "[Tests] Generate Tests", mode = "v" },
    },
  },
}
