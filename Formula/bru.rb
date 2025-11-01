class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.26"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.26/bru-aarch64-apple-darwin.tar.gz"
      sha256 "07c512d675c88b0f6c08dd53cc0d2075eeea0bb02a5f5ccf18e52a591bfb6185"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.26/bru-x86_64-apple-darwin.tar.gz"
      sha256 "078014987a13d4c83f276e4142f1b35ffb359fc76fd90b9df89409837fe5fb83"
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
