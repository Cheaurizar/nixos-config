{ ... }:
{
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;
        extensions.dap-lldb.enable = true;
      };
      dap-python = {
        enable = true;
        adapterPythonPath = "python3";
      };
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        options.desc = "Toggle breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "require('dap').continue";
        options.desc = "Débogueur : continuer";
      }
      {
        mode = "n";
        key = "<leader>do";
        action.__raw = "require('dap').step_over";
        options.desc = "Débogueur : step over";
      }
      {
        mode = "n";
        key = "<leader>di";
        action.__raw = "require('dap').step_into";
        options.desc = "Débogueur : step into";
      }
      {
        mode = "n";
        key = "<leader>du";
        action.__raw = "require('dapui').toggle";
        options.desc = "Toggle UI débogueur";
      }
    ];
  };
}
