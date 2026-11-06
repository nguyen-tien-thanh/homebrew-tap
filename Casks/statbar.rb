cask "statbar" do
  version "1.0.7"
  sha256 "37b96f2c8a365b6fa39a59f4a01a85a97a27250090b84c37b06ef621920d2a33"

  url "https://github.com/nguyen-tien-thanh/statbar/releases/download/v#{version}/StatBar.dmg"
  name "StatBar"
  desc "Lightweight menu bar system monitor with a clean/uninstall/optimize toolbox"
  homepage "https://github.com/nguyen-tien-thanh/statbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "StatBar.app"

  # StatBar is ad-hoc signed (not notarized). Clearing the quarantine flag lets it open
  # without the Gatekeeper "Open Anyway" dance; it updates itself in-app afterwards.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/StatBar.app"],
        writable_paths: ["StatBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "local.statbar.app"

  zap delete: [
        "/etc/sudoers.d/statbar",
        "/Library/PrivilegedHelperTools/local.statbar.helper",
      ],
      trash:  "~/Library/Preferences/local.statbar.app.plist"
end
