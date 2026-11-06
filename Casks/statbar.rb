cask "statbar" do
  version "1.0.5"
  sha256 "347f1845d2b77671d9f9778561f9f51a63997bbdd328e49a9574c1d235359b26"

  url "https://github.com/nguyen-tien-thanh/statbar/releases/download/v#{version}/StatBar.dmg"
  name "StatBar"
  desc "Lightweight menu bar system monitor with a clean/uninstall/optimize toolbox"
  homepage "https://github.com/nguyen-tien-thanh/statbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "StatBar.app"

  # StatBar is ad-hoc signed (not notarized). Clearing the quarantine flag lets it open
  # without the Gatekeeper "Open Anyway" dance; it updates itself in-app afterwards.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/StatBar.app"]
  end

  uninstall quit: "local.statbar.app"

  zap trash:  "~/Library/Preferences/local.statbar.app.plist",
      delete: [
        "/Library/PrivilegedHelperTools/local.statbar.helper",
        "/etc/sudoers.d/statbar",
      ]
end
