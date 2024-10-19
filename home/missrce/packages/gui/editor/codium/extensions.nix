{
  extensions,
  pkgs,
}:
builtins.concatLists (builtins.attrValues {
  git = with extensions; [
    maattdd.gitless
    paragdiwan.gitpatch
    fabiospampinato.vscode-diff
  ];

  github = with extensions; [
    github.vscode-github-actions
    pkgs.vscode-extensions.github.vscode-pull-request-github
  ];

  tools = with extensions; [
    antiantisepticeye.vscode-color-picker
    formulahendry.auto-rename-tag
    pkgs.vscode-extensions.ms-vscode.hexeditor
    ms-vscode.live-server
    tintinweb.vscode-decompiler
    twxs.cmake
    vivaxy.vscode-conventional-commits
    zh9528.file-size
    ultram4rine.vscode-choosealicense
  ];

  http = with extensions; [
    anweber.httpbook
    anweber.vscode-httpyac
  ];

  astro = with extensions; [
    astro-build.astro-vscode
  ];

  js = with extensions; [
    esbenp.prettier-vscode
    prisma.prisma
    wix.vscode-import-cost
  ];

  ts = with extensions; [
    gregorbiswanger.json2ts
    yoavbls.pretty-ts-errors
  ];

  config = with extensions; [
    editorconfig.editorconfig
  ];

  misc-languages = with extensions; [
    eww-yuck.yuck
    borrajo.te
    grapecity.gc-excelviewer
    james-yu.latex-workshop
    mechatroner.rainbow-csv
    mrmlnc.vscode-json5
    redhat.vscode-yaml
    thog.vscode-asl # UEFI ASL
    zamerick.vscode-caddyfile-syntax
  ];

  ui = with extensions; [
    exodiusstudios.comment-anchors
    usernamehw.errorlens
  ];

  theming = with extensions; [
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
  ];

  java = with extensions; [
    fwcd.kotlin
    redhat.java
    vscjava.vscode-gradle
    vscjava.vscode-java-debug
    vscjava.vscode-maven
  ];

  nix = with extensions; [
    jnoortheen.nix-ide
    mkhl.direnv
  ];

  discord = with extensions; [
    leonardssh.vscord
  ];

  docker = with extensions; [
    ms-azuretools.vscode-docker
  ];

  zig = with extensions; [
    ziglang.vscode-zig
  ];

  rust = with extensions; [
    pkgs.vscode-extensions.rust-lang.rust-analyzer
    tamasfe.even-better-toml
  ];

  css = with extensions; [
    stylelint.vscode-stylelint
  ];

  roblox = with extensions; [
    evaera.vscode-rojo
    evaera.roblox-api-explorer
    roblox-ts.vscode-roblox-ts
    nightrains.robloxlsp
  ];

  lua = with extensions; [
    sumneko.lua
  ];

  svelte = with extensions; [
    svelte.svelte-vscode
  ];
})
