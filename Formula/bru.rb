class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.2.1"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.1/bru-aarch64-apple-darwin.tar.gz"
      sha256 "2816383ff63c4a4a9b57291e5a041feedea3edcc07ff411b9d6b85725a9d951d"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.2.1/bru-x86_64-apple-darwin.tar.gz"
      sha256 "d86e1107685855a7322dfec1f6a1e1ae1f2f11183bf0b2f1713864199f9dfa95"
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
