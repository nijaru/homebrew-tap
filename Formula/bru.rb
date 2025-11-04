class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.28"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.28/bru-aarch64-apple-darwin.tar.gz"
      sha256 "c98aa72061e6c12c9e5351571ae17cbc3fa15f429294701b3d87a9bae7bb8cd8"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.28/bru-x86_64-apple-darwin.tar.gz"
      sha256 "88f4d719215c47ca43caa1f10ef4a84aa2ade56c26e4cf50462be2260ab70abf"
    end
  end

  def install
    bin.install "bru"
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
