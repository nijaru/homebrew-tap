class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.21"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.21/bru-aarch64-apple-darwin.tar.gz"
      sha256 "a6b2d00892c60c3ffacee31114b260bc8256c6621cce0af7b2165e61c3aa0703"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.21/bru-x86_64-apple-darwin.tar.gz"
      sha256 "e764fa24f0224753ecf9e9919c53199d38fae37961f9c6364dd1c9e2ce252fe7"
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
