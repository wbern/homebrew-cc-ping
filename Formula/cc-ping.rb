class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.18.1"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-arm64"
      sha256 "689bc7f59eedd08d157e3bb5de4d4849a406af57f6368a9cfa3ee3a97938c7e2"
    else
      url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-darwin-x64"
      sha256 "5095a5db7eb414a437fdaf17fdefc68094faa92d525b927110bd4474c3b0fa14"
    end
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "96f7487422659f616f9c8e304a7f3a62009dd6e064cf092d5b1aefa9a27dfd5c"
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
