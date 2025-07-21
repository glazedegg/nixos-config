{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnumake
    gcc
    ripgrep
    unzip
    xclip
  ];
  
  programs.neovim = {
    enable   = true;         # turn on the module
    # package  = pkgs.neovim-unwrapped;  # which Neovim to install
    # viAlias  = true;         # make vi → nvim
    # vimAlias = true;         # make vim → nvim

    # embed your init.lua under the vimscript loader
    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./init.lua}
      EOF
    '';

    # NB: when you use lazy.nvim, you don’t use `programs.neovim.plugins`
    #    because lazy.nvim itself handles fetching/building plugins at runtime.
  };
}

