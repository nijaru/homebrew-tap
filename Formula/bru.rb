class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.2.4"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.4/bru-aarch64-apple-darwin.tar.gz"
      sha256 "039e74567b33632b84f5f31944e85e5c46931cffa7c5f6b91c7f7e8788a1ac79"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.4/bru-x86_64-apple-darwin.tar.gz"
      sha256 "e593e1fcec955c8b451972513d1d236e171f4bc9f28144cc64f2240bd1a75c47"
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
