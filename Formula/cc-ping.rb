class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.15.5"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-arm64"
      sha256 "8ef9059c14057d23dd751245f2ee9d749eb9a7759d0a38004e1e47e691806523"
    else
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-x64"
      sha256 "2af2f299afd69547f1ef2e150478100d7dc2364fb5541103af93b9be773b460a"
    end
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "270d5b4132ff7fd2e18fefe153641a8d03394360837e17c48dab5b6aca1d854b"
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

    if OS.mac?
      system "codesign", "--remove-signature", bin/"cc-ping"
      system "codesign", "--force", "--sign", "-", bin/"cc-ping"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-ping --version")
  end
end
