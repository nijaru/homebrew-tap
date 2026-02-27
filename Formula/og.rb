class Og < Formula
  desc "Semantic code search — multi-vector embeddings + BM25"
  homepage "https://github.com/nijaru/omengrep"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.1/og-aarch64-apple-darwin.tar.gz"
      sha256 "d19099c689b8c96eec9e9142771b4d4b2399372a78dbe2759ed0e472d33c78dd"
    end

    on_intel do
      url "https://github.com/nisha256 "711cb2130ca676207a39cee1a20e973328cc87f9b11650347c1f8b6abdcaf1b4"e/refs/tags/v0.0.1.tar.gz"
      sha256 "PLACEHOLDER"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.1/og-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/omengrep/releases/download/v0.0.1/og-x86_64-unknown-linux-gnu.tar.gz"
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
