class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.2.3"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.3/bru-aarch64-apple-darwin.tar.gz"
      sha256 "771074dd196c57132795a070d17ecf2ea6affe9cd53633f4fe99ca9fe8374dea"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.3/bru-x86_64-apple-darwin.tar.gz"
      sha256 "eec866a98614702d4159d8a2c3e7d4a635a956d49b9aec972d45d7d0fb281368"
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
