{ osConfig, pkgs, lib, ... }: let
  inherit (lib.strings) toUpper;
  inherit (lib.meta) getExe;

  inherit (osConfig.catppuccin) flavor;
in {
  "workbench.colorTheme" = "Catppuccin ${(toUpper (builtins.substring 0 1 flavor)) + (builtins.substring 1 (builtins.stringLength flavor) flavor)}";
  "workbench.iconTheme" = "catppuccin-${flavor}";
  "github.gitAuthentication" = false;
  "terminal.integrated.fontFamily" = builtins.concatStringsSep ", " (map (font: "'${font}'") osConfig.fonts.fontconfig.defaultFonts.monospace);
  "editor.cursorBlinking" = "expand";
  "editor.cursorSmoothCaretAnimation" = "on";
  "terminal.integrated.cursorBlinking" = true;
  "terminal.integrated.cursorStyle" = "line";
  "terminal.integrated.cursorWidth" = 2;
  "git.confirmSync" = false;
  "git.autofetch" = true;
  "editor.semanticHighlighting.enabled" = true;
  "browser-preview.format" = "png";
  "browser-preview.startUrl" = "https://duckduckgo.com";
  "browser-preview.chromeExecutable" = "chromium";
  "vsicons.dontShowNewVersionMessage" = true;
  "files.exclude" = {
    "**/.classpath" = true;
    "**/.project" = true;
    "**/.settings" = true;
    "**/.factorypath" = true;
  };
  "files.autoSave" = "onFocusChange";
  "editor.smoothScrolling" = true;
  "workbench.list.smoothScrolling" = true;
  "window.dialogStyle" = "custom";
  "debug.onTaskErrors" = "debugAnyway";
  "gitlens.views.commits.files.layout" = "list";
  "git.enableSmartCommit" = true;
  "terminal.integrated.scrollback" = 2000;
  "editor.fontFamily" = "'MonaspiceNe Nerd Font', 'DejaVu Sans Mono'";
  "editor.fontLigatures" = true;
  "terminal.external.linuxExec" = "foot";
  "rpc.buttonEnabled" = true;
  "rpc.buttonInactiveLabel" = "";
  "rpc.buttonInactiveUrl" = "";
  "rpc.lowerDetailsDebugging" = "Debugging {file_name}:{current_line}:{current_column}";
  "rpc.detailsDebugging" = "In {workspace} {problems}";
  "rpc.smallImage" = "Codium";
  "workbench.enableExperiments" = false;
  "update.mode" = "none";
  "typescript.updateImportsOnFileMove.enabled" = "always";
  "gitanimate.playbackFolder" = "/tmp/git-animate";
  "security.workspace.trust.untrustedFiles" = "open";
  "[typescript]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "gitlens.plusFeatures.enabled" = false;
  "githubPullRequests.terminalLinksHandler" = "vscode";
  "svelte.enable-ts-plugin" = true;
  "[json]" = {
    "editor.defaultFormatter" = "vscode.json-language-features";
  };
  "workbench.sideBar.location" = "left";
  "[jsonc]" = {
    "editor.defaultFormatter" = "vscode.json-language-features";
  };
  "[javascript]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[html]" = {
    "editor.defaultFormatter" = "vscode.html-language-features";
  };
  "zig.path" = "zig";
  "zig.zls.path" = "zls";
  "zig.initialSetupDone" = true;
  "terminal.integrated.shellIntegration.enabled" = true;
  "cmake.configureOnOpen" = false;
  "githubPullRequests.pullBranch" = "never";
  "ipynb.experimental.pasteImages.enabled" = true;
  "editor.experimental.pasteActions.enabled" = true;
  "typescript.tsserver.experimental.enableProjectDiagnostics" = true;
  "timeline.pageOnScroll" = true;
  "gitlens.views.repositories.showIncomingActivity" = true;
  "workbench.settings.enableNaturalLanguageSearch" = false;
  "window.commandCenter" = true;
  "git.allowForcePush" = true;
  "vs-browser.autoCompleteUrl" = "https://www.duckduckgo.com/search?q=";
  "vs-browser.localProxyServer.cookieDomainRewrite" = true;
  "vs-browser.proxyMode" = true;
  "vs-browser.localProxyServer.forceLocation" = true;
  "vs-browser.localProxyServer.enabled" = true;
  "diffEditor.ignoreTrimWhitespace" = false;
  "terminal.integrated.smoothScrolling" = true;
  "workbench.editorAssociations" = {
    "*.png" = "imagePreview.previewEditor";
  };
  "git.openRepositoryInParentFolders" = "always";
  "diffEditor.renderSideBySide" = false;
  "window.titleBarStyle" = "custom";
  "javascript.updateImportsOnFileMove.enabled" = "always";
  "redhat.telemetry.enabled" = false;
  "editor.largeFileOptimizations" = false;
  "npm.keybindingsChangedWarningShown" = true;
  "terminal.integrated.defaultProfile.linux" = "bash";
  "workbench.editor.empty.hint" = "hidden";
  "workbench.startupEditor" = "none";
  "[css]" = {
    "editor.defaultFormatter" = "vscode.css-language-features";
  };
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "${getExe pkgs.nil}";
  "nix.formatterPath" = "${getExe pkgs.nixpkgs-fmt}";
  "accessibility.signals.terminalBell" = {
    "sound" = "on";
  };
  "prisma.showPrismaDataPlatformNotification" = false;
}
