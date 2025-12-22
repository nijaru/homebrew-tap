class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.8"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.8/jb-aarch64-apple-darwin.tar.gz"
      sha256 "9ba5041bafd65b3011a57b87e74781d2d85b193fe7b3e28acd6611168e33c4ee"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.8.tar.gz"
      sha256 "0be32c98843372e42d6ab4f6850c99378ffb91f72876ed7fda202f87a7d5af89"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.8/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "94eb18969a04216e325991e7b16af272f1745cbe9b1f615267cfb2bd3fb01c93"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.8/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8130b80a54b60d95170a1998ce194aa4cf756ba771ab1ab36dfb817eed7b1492"
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
