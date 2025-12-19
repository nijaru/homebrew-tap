class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.3"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.3/jb-aarch64-apple-darwin.tar.gz"
      sha256 "2ba3f760784131685f3dd49f3feb1bdde4be99fb613ae04b69701dc81477b084"
    end

    on_intel do
      # Build from source on Intel Mac
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.3.tar.gz"
      sha256 "21c43126af60a7eca097494d0a43a8b05959ba059434524dbd359858f5f3c1bf"
      depends_on "rust" => :build
    end
  end

  on_linux do
    # Build from source on Linux
    url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.3.tar.gz"
    sha256 "21c43126af60a7eca097494d0a43a8b05959ba059434524dbd359858f5f3c1bf"
    depends_on "rust" => :build
  end

  def install
    if File.exist?("jb")
      # Prebuilt binary
      bin.install "jb"
    else
      # Build from source
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jb --version")
    assert_match "Background job manager", shell_output("#{bin}/jb --help")
  end
end
