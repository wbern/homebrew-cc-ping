class AgentInstructions < Formula
  desc "TDD workflow commands for AI coding agents (Claude Code, OpenCode, Codex)"
  homepage "https://github.com/wbern/agent-instructions"
  url "https://registry.npmjs.org/@wbern/agent-instructions/-/agent-instructions-4.0.0.tgz"
  sha256 "ef04ece8cc8944750d000be546c09213a6e8cdc2ed94c32172008f6b76947d58"
  license "MIT"
  version "4.0.0"

  livecheck do
    url "https://github.com/wbern/agent-instructions/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-instructions --version")
  end
end
