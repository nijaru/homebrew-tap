class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.33"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.33/bru-aarch64-apple-darwin.tar.gz"
      sha256 "8bd9ad669431181e856cf6039dc80c85eb1c20daa02ebc1e26c02e1311cdbba9"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.33/bru-x86_64-apple-darwin.tar.gz"
      sha256 "788a2c0e289a3f1fffb758c2c92bffaa5d8bb9779a43c8295efacd10c5503dc9"
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
