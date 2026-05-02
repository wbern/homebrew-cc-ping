class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.20.0"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-arm64"
      sha256 "1590f27435999cdf70278041ae473a2719a036ffa42ce3be0f9e846988ea566e"
    else
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-x64"
      sha256 "a25b171f0a816b5b2fa8a5c5d60f359a05c76f4ac24e1acbc1bcecf6f5088e90"
    end
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "8acd49d5cde7b88f5c49762ff1e9bf0db0dafbd8265c878ef173504fe8175424"
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
