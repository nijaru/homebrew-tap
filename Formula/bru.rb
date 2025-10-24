class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "d3269ae4437e276a3054dddd5fb456b54340b932c949a5f4ac099ef6613b830f"
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
