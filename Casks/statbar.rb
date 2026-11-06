cask "statbar" do
  version "1.0.6"
  sha256 "4bdef335c8835c931173663adf866ee6458c222777aa742a35dfd19443a0a6eb"

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
