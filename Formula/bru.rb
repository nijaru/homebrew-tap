class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "6477518ced51fdfdd8f02d32d358f49c9024e541dfead0141d984c77f4112b56"
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
