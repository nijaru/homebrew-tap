class Og < Formula
  desc "Semantic code search — multi-vector embeddings + BM25"
  homepage "https://github.com/nijaru/omengrep"
  version "0.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.3/og-aarch64-apple-darwin.tar.gz"
      sha256 "b323bebf926abd7a65002325340d3a32a1193fba25af0ed173730e30c914bd98"
    end

    on_intel do
      url "https://github.com/nisha256 "ca9a9da328f5a7194e777f82f680ef0d3fd2a9f5a2902330fb32a6205df06197"e/refs/tags/v0.0.3.tar.gz"
      sha256 "PLACEHOLDER"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.3/og-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.3/og-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    if File.exist?("og")
      bin.install "og"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/og --version")
    assert_match "Semantic code search", shell_output("#{bin}/og --help")
  end
end
