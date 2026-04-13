class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "0.0.0"

  # Formula is auto-updated by CI on each release.
  # See: https://github.com/wbern/cc-ping/blob/main/.github/workflows/update-homebrew.yml

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(%r{href=.*?/tag/v(\d+(?:\.\d+)+)(["' >])})
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-arm64"
      sha256 "placeholder"
    else
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-x64"
      sha256 "placeholder"
    end
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "placeholder"
  else
    odie "cc-ping: unsupported platform"
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "cc-ping-darwin-arm64" : "cc-ping-darwin-x64"
    else
      "cc-ping-linux-x64"
    end
    bin.install binary_name => "cc-ping"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-ping --version")
  end
end
