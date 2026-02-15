class Og < Formula
  desc "Semantic code search — multi-vector embeddings + BM25"
  homepage "https://github.com/nijaru/omengrep"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.1.0/og-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/omengrep/archive/refs/tags/v0.1.0.tar.gz"
      sha256 "PLACEHOLDER"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.1.0/og-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/omengrep/releases/download/v0.1.0/og-x86_64-unknown-linux-gnu.tar.gz"
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
