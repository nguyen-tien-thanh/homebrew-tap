cask "statbar" do
  version "1.0.9"
  sha256 "2fe68ce326bbc943e4bc09807f4b55ec72ea4ea88586ffd316a00b7c9a037c85"

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
