class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "ca40ffb5dc5945d4cfd7c24f36dc2f9bc581f6db3a78dd82c4d4f2ef2c0bef12"
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
