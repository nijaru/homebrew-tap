class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.17"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.17/jb-aarch64-apple-darwin.tar.gz"
      sha256 "ed1bf37dadd751173e71fb48862f6589244d9b88f01f438639a8f4a1f43dd226"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.17.tar.gz"
      sha256 "ee2e9faedaab41bceaf3463aaca8486ec81f1aa8cd4ffffc8ca646df1bb2902f"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.17/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b58d9eb78998f7a83efd65575a0d140025135139521ea75c5be76da13afe876d"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.17/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f72a846ddec292387cd033299fdf8064761b321ab9aa32a7a4e89cd04baad72a"
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
