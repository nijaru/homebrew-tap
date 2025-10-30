class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.18"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.18/bru-aarch64-apple-darwin.tar.gz"
      sha256 "2a305cfb3e8a2bca5ea84f220532bc37e7a3c4f61c5abe422e0d0680ca413fa7"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.18/bru-x86_64-apple-darwin.tar.gz"
      sha256 "48affd9729d2ddd3c52741623070a0b01ff533557bc9f2fa374798e96014cf00"
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
