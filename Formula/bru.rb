class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  url "https://github.com/nijaru/kombrucha/archive/refs/tags/v0.1.13.tar.gz"
  sha256 "76ffa0ef5f72efd427b830cebc3ae750644408fff3b3cd9ac2d43cf679ef20b9"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Test actual functionality, not just --version (Homebrew best practice)

    # Test 1: Verify bru can search formulae via Homebrew API
    output = shell_output("#{bin}/bru search wget")
    assert_match "wget", output

    # Test 2: Verify bru can fetch and parse formula metadata
    info_output = shell_output("#{bin}/bru info wget")
    assert_match "wget", info_output
    assert_match(/Internet file retriever|URL retriever|network downloader/i, info_output)

    # Test 3: Verify bru can resolve dependencies
    deps_output = shell_output("#{bin}/bru deps wget")
    assert_match(/openssl|libidn/i, deps_output)
  end
end
