class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.4"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.4/jb-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.4.tar.gz"
      sha256 "PLACEHOLDER"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.4/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.4/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
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
