class Og < Formula
  desc "Semantic code search — multi-vector embeddings + BM25"
  homepage "https://github.com/nijaru/omengrep"
  url "https://github.com/nijaru/omengrep/releases/download/v0.0.3/og-aarch64-apple-darwin.tar.gz"
  sha256 "b323bebf926abd7a65002325340d3a32a1193fba25af0ed173730e30c914bd98"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "og"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/og --version")
    assert_match "Semantic code search", shell_output("#{bin}/og --help")
  end
end
