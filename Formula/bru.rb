class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "bbc8dd9bc7e9aed3f40066a3a27587030651060b7b2829cb080d72bf6b855f4f"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "bru #{version}", shell_output("#{bin}/bru --version")
  end
end
