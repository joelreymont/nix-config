{
  config,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    userEmail = "18791+joelreymont@users.noreply.github.com";
    userName = "Joel Reymont";
    lfs = {
      enable = true;
      skipSmudge = true;
    };
    extraConfig = {
      credential = {
        helper = "osxkeychain";
      };
      core = {
        autocrlf = "input";
      };
      color = {
        status = "auto";
        branch = "auto";
      };
      github.token = "ff6b31a022d67235bca560f762b7f831";
      user.signingkey = "5EE3518221A8F395";
      init = {
        defaultBranch = "master";
      };
      alias = {
        an = "commit -a --amend --no-edit";
        ci = "commit";
        co = "checkout";
        st = "status";
        dc = "diff --cached";
        ap = "add -p";
        cp = "cherry-pick";
        vv = "rev-parse --short HEAD";
        pb = "pull --rebase";
        rc = "rebase --continue";
        br = "branch";
        rh = "reset --hard";
        re = "restore --staged";
        lo = "log --pretty=oneline";
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
    attributes = [
      "*.jpg -crlf -diff -merge"
      "*.png -crlf -diff -merge"
      "*.tiff -crlf -diff -merge"
      "*.gif -crlf -diff -merge"
      "*.bmp -crlf -diff -merge"
      "*.pbxproj -crlf -diff -merge"
      "*.pkg -crlf -diff -merge"
    ];
    ignores = [
      "*.[oa]"
      "*.dylib"
      "*.gz"
      "*~"
      "*.bak"
      "*.old"
      "*junk*"
      "scratch*"
      "attic*"
      "*.fasl"
      ".*\#.*\#$"
      # xcode noise
      "*.pbxuser"
      # macOS noise
      ".DS_Store"
      "*.dSYM"
      "*.mdb"
    ];
  };
}
