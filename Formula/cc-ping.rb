class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.21.2"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    # Build from source on the user's machine. Pre-built binaries
    # downloaded from GitHub Releases get tagged with macOS Sequoia's
    # com.apple.provenance xattr, which Gatekeeper blocks for
    # ad-hoc-signed Mach-O binaries.
    url "https://github.com/wbern/cc-ping/archive/refs/tags/v#{version}.tar.gz"
    sha256 "ad6c1109dc84782125194503ae1bf1e8d2a8f2f2298666b7af65c81c1482ada3"
    depends_on "oven-sh/bun/bun" => :build
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "2084e348949f7b03eb2c3a7df40d81c911f02922dcdd3dc1b6a191c18d1dde7f"
  else
    odie "cc-ping: unsupported platform"
  end

  def install
    if OS.mac?
      ENV["BUN_INSTALL_CACHE_DIR"] = buildpath/"bun-cache"
      system "bun", "install", "--no-save"
      system "bun", "build", "--compile", "--minify",
             "--define", "__VERSION__=\"\\\"#{version}\\\"\"",
             "./src/cli.ts", "--outfile", "cc-ping"
      # Re-sign ad-hoc to satisfy Gatekeeper after compile.
      system "codesign", "--remove-signature", "cc-ping"
      system "codesign", "--force", "--sign", "-", "cc-ping"
      bin.install "cc-ping"
    else
      bin.install "cc-ping-linux-x64" => "cc-ping"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-ping --version")
  end
end
