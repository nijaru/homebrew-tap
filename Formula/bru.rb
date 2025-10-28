class Bru < Formula
  desc "Fast, parallel package manager compatible with Homebrew formulae"
  homepage "https://github.com/nijaru/kombrucha"
  version "0.1.13"
  license "MIT OR Apache-2.0"
  head "https://github.com/nijaru/kombrucha.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.13/bru-aarch64-apple-darwin.tar.gz"
      sha256 "48e35b92638d323bb8dd505d800663c670500f860d144cae3ec9b0bdd69c3782"
    end

    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.13/bru-x86_64-apple-darwin.tar.gz"
      sha256 "c6b6b29d91fb3e0691b2769f89d8b0c289dbd80f3af3dd440261725d92b99e66"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nijaru/kombrucha/releases/download/v0.1.13/bru-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6f59d21c2308c228b6d768697e4fc9bd15e914610bde4c0e4b424d6d7bac63c3"
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
