{ ... }:
{
  programs.zsh.initContent = ''
    gitctx() {
      local out="''${1:-/tmp/git-context.md}"
      {
        echo "# Git context"
        echo
        echo "## Request"
        echo
        echo "Write the commit message(s) for the staged changes below, following my commit style. Propose a split if the changes have unrelated concerns."
        echo
        echo "## Staged files"
        git diff --staged --stat
        echo
        echo "## Why I'm making these changes"
        echo
        echo '<!-- Describe the motivation behind each group of changes -->'
        echo '<!-- Mention if you want one or several commits -->'
        echo
        echo "---"
        echo
        echo "## Staged diff"
        echo '```diff'
        git diff --staged
        echo '```'
      } > "$out"
      nvim "$out"
      echo "→ $out"
    }
  '';
}
