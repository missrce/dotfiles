{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) concatLists;
  inherit (lib.strings) concatMapStrings;
in {
  programs.chromium = mkIf osConfig.missos.programs.browser.chromium {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "pncfbmialoiaghdehhbnbhkkgmjanfhe" # uBlacklist
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
      "emffkefkbkpkgpdeeooapgaicgmcbolj" # Wikiwand
      "ngonfifpkpeefnhelnfdkficaiihklid" # ProtonDB
      "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
      {
        id = "bhemdfncmhpcjlhejcneidchipcelbho";
        updateUrl = "https://raw.githubusercontent.com/missrce/unsuggestive-suggestions/refs/heads/main/updates.xml";
      } # Unsuggestive Suggestions
    ];

    package = pkgs.chromium.override {
      enableWideVine = true;

      # https://github.com/secureblue/hardened-chromium
      # https://github.com/secureblue/secureblue/blob/e500f078efc5748d5033a881bbbcdcd2de95a813/files/system/usr/etc/chromium/chromium.conf.md
      commandLineArgs = concatLists [
        # Aesthetics
        [
          "--gtk-version=4"
        ]

        # Performance
        [
          "--enable-gpu-rasterization"
          "--enable-oop-rasterization"
          "--enable-zero-copy"
          "--ignore-gpu-blocklist"
        ]

        # Wayland (I don't want to use any device without Wayland so this is not optional)
        [
          "--ozone-platform=wayland"
          "--enable-features=UseOzonePlatform"
        ]

        # Etc
        [
          "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"
          "--disable-reading-from-canvas"
          "--no-first-run"
          "--disable-wake-on-wifi"
          "--disable-breakpad"

          # please stop asking me to be the default browser
          "--no-default-browser-check"

          # I don't need these, thus I disable them
          "--disable-speech-api"
          "--disable-speech-synthesis-api"
        ]

        # Security
        [
          # Use strict extension verification
          "--extension-content-verification=enforce_strict"
          "--extensions-install-verification=enforce_strict"
          # Disable pings
          "--no-pings"
          # Require HTTPS for component updater
          "--component-updater=require_encryption"
          # Disable crash upload
          "--no-crash-upload"
          # don't run things without asking
          "--no-service-autorun"
          # Disable sync
          "--disable-sync"

          (
            "--enable-features="
            + concatMapStrings (x: x + ",") [
              # Enable visited link database partitioning
              "PartitionVisitedLinkDatabase"
              # Enable prefetch privacy changes
              "PrefetchPrivacyChanges"
              # Enable split cache
              "SplitCacheByNetworkIsolationKey"
              "SplitCodeCacheByNetworkIsolationKey"
              # Enable partitioning connections
              "EnableCrossSiteFlagNetworkIsolationKey"
              "HttpCacheKeyingExperimentControlGroup"
              "PartitionConnectionsByNetworkIsolationKey"
              # Enable strict origin isolation
              "StrictOriginIsolation"
              # Enable reduce accept language header
              "ReduceAcceptLanguage"
              # Enable content settings partitioning
              "ContentSettingsPartitioning"
            ]
          )

          (
            "--disable-features="
            + concatMapStrings (x: x + ",") [
              # Disable autofill
              "AutofillPaymentCardBenefits"
              "AutofillPaymentCvcStorage"
              "AutofillPaymentCardBenefits"
              # Disable third-party cookie deprecation bypasses
              "TpcdHeuristicsGrants"
              "TpcdMetadataGrants"
              # Disable hyperlink auditing
              "EnableHyperlinkAuditing"
              # Disable showing popular sites
              "NTPPopularSitesBakedInContent"
              "UsePopularSitesSuggestions"
              # Disable article suggestions
              "EnableSnippets"
              "ArticlesListVisible"
              "EnableSnippetsByDse"
              # Disable content feed suggestions
              "InterestFeedV2"
              # Disable media DRM preprovisioning
              "MediaDrmPreprovisioning"
              # Disable autofill server communication
              "AutofillServerCommunication"
              # Disable new privacy sandbox features
              "PrivacySandboxSettings4"
              "BrowsingTopics"
              "BrowsingTopicsDocumentAPI"
              "BrowsingTopicsParameters"
              # Disable translate button
              "AdaptiveButtonInTopToolbarTranslate"
              # Disable detailed language settings
              "DetailedLanguageSettings"
              # Disable fetching optimization guides
              "OptimizationHintsFetching"
              # Partition third-party storage
              "DisableThirdPartyStoragePartitioningDeprecationTrial2"

              # Disable media engagement
              "PreloadMediaEngagementData"
              "MediaEngagementBypassAutoplayPolicies"
            ]
          )
        ]
      ];
    };
  };
}
