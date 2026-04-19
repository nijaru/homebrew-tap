class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.15"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.15/jb-aarch64-apple-darwin.tar.gz"
      sha256 "81e4ea314636e4547de0b993eb9d799c1b0fd1252029b24e1448922e23100211"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.15.tar.gz"
      sha256 "2c152b937349abb74ba4d7cb712505306a8274a6e79c06f6731068e25318c16e"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.15/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16e76e3218d4b7930bf4d2083ce1778aed1a7f26c0cb623409140185b221997a"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.15/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e539986ac528c9b8dfb2535bc26162d8f117427e825423c7b9e3ec307f719853"
    end
  end

  def install
    if File.exist?("jb")
      bin.install "jb"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jb --version")
    assert_match "Background job manager", shell_output("#{bin}/jb --help")
  end
end
