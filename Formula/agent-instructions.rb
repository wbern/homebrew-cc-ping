class AgentInstructions < Formula
  desc "TDD workflow commands for AI coding agents (Claude Code, OpenCode, Codex)"
  homepage "https://github.com/wbern/agent-instructions"
  url "https://registry.npmjs.org/@wbern/agent-instructions/-/agent-instructions-3.0.0.tgz"
  sha256 "a190c128a9d78943612d6acd7df435aefe677f716c9c2bc51f06bdc343687c18"
  license "MIT"
  version "3.0.0"

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
