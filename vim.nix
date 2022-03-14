{ pkgs, ... }:

let 
  fern-git-status = pkgs.vimUtils.buildVimPlugin {
    name = "fern-git-status";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-git-status.vim";
      rev = "151336335d3b6975153dad77e60049ca7111da8e";
      sha256 = "9N+T/MB+4hKcxoKRwY8F7iwmTsMtNmHCHiVZfcsADcc=";
    };
  };
  fern-hijack = pkgs.vimUtils.buildVimPlugin {
    name = "fern-hijack";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-hijack.vim";
      rev = "5989a1ac6ddffd0fe49631826b6743b129992b32";
      sha256 = "zvTTdkyywBl0U3DdZnzIXunFTZR9eRL3fJFWjAbb7JI=";
    };
  };
  fern-renderer-nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "fern-renderer-nerdfont";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern-renderer-nerdfont.vim";
      rev = "1a3719f226edc27e7241da7cda4bc4d4c7db889c";
      sha256 = "rWsTB5GkCPqicP6zRoJWnwBUAPDklGny/vjeRu2e0YY=";
    };
  };
  nerdfont = pkgs.vimUtils.buildVimPlugin {
    name = "nerdfont";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "nerdfont.vim";
      rev = "b7dec1f9798470abf9ef877d01e4415d72f792be";
      sha256 = "NYonYP54PVUwHbU+Q/D7MqhVh+IB0B17KaHtkg19PaI=";
    };
  };
in {
      environment.variables = { EDITOR = "vim"; };
      environment.systemPackages = [
        (pkgs.vim_configurable.customize {
          name = "vim";
          wrapGui = true;
          vimrcConfig = {
            customRC = (builtins.readFile ./init.vim);
            packages.myVimPackage = with pkgs.vimPlugins; {
              start = [
                coc-nvim
                coc-tsserver
                coc-tabnine
                coc-rust-analyzer
                coc-pyright
                coc-json
                coc-html
                coc-css
                vim-polyglot
                asyncrun-vim
                asynctasks-vim
                vim-airline
                vim-airline-themes
                vim-surround
                vim-fugitive
                vim-gitgutter
                everforest
                sonokai
                fern-vim
                fern-hijack
                fern-git-status
                fern-renderer-nerdfont
                nerdfont
                # vim-clap
              ];
              opt = [
                vim-prisma
                vista-vim
              ];
            };
          };
        })
    ];
}
