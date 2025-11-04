class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.29"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.29/bru-aarch64-apple-darwin.tar.gz"
      sha256 "c6714b5c0ae4d0765982a0e38ed237d47acb0025150f9425e4377d20d1864a24"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.29/bru-x86_64-apple-darwin.tar.gz"
      sha256 "d2317db61ea4fe26b7ca3955e69f9721d73f6990f663277bb2d7268c5f1d6a76"
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
