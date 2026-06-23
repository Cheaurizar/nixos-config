{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      # Formatteurs Python
      black
      ruff
      # Formatteur Nix
      nixfmt
      # Formatteur Lua
      stylua
      # LaTeX
      (texlive.combine {
        inherit (texlive)
          scheme-medium
          minted
          fvextra
          upquote
          catchfile
          xstring
          framed
          ;
      })
      zathura
      # DAP pour Rust (via codelldb)
      lldb # débogueur Rust/C/C++
      xdotool
    ];

    # Config Lua supplémentaire
    extraConfigLua = ''
      -- Highlight après yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank({ timeout = 150 })
        end,
      })

      -- DAP pour Rust (codelldb)
      local dap = require('dap')
      dap.adapters.codelldb = {
        type = 'server',
        port = 13000,
        executable = {
          command = 'codelldb',
          args = { '--port', '13000' },
        },
      }
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Chemin vers executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = vim.fn.getcwd(),
          stopOnEntry = false,
        },
      }

      -- Ouvrir/fermer l'UI DAP automatiquement
      local dapui = require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    '';
  };
}
