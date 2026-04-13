class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.15.3"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-arm64"
      sha256 "2b0a12533192bb22840b7308aa67b973fcce549fdadcf3e071d30636204c8ccc"
    else
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-x64"
      sha256 "f499bfdd34632bcfb6a937a7d1b44d8d4156c13734fa8a0529b1c29b4f0b994b"
    end
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "42fe267eb35b741f68b37ff358b8676b8664a5781aedf7d6ca6c712b74e6ae9a"
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

    # Clear macOS quarantine/provenance to allow unsigned Bun-compiled binaries to run
    if OS.mac?
      system "xattr", "-c", bin/"cc-ping"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-ping --version")
  end
end
