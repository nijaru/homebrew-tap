class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "6ae6decac50524869f6a6f470699df626b858335f64c73acc7fd7d4978cbcf9f"
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
