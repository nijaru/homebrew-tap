class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.16"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.16/jb-aarch64-apple-darwin.tar.gz"
      sha256 "eaaa3bb674ecc94897c0ed85d12812dd1b974353f195bc7913623e7f1812560b"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.16.tar.gz"
      sha256 "273e23c2df73c08712d47ff3c238430efad84aef8b7ac224e09d6c2e812e0490"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.16/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33fa959d5c6d86949b64109d3818157f663b2092cdd6c278c64ad04f1fc11903"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.16/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e953c5224e8ec48dea719fb1a281cca26b6d021ca41ea4500c5e7f456bd6808e"
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
