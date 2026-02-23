class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.14"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.14/jb-aarch64-apple-darwin.tar.gz"
      sha256 "3ce6bef0d34db65b2b79b0c30f25433c113fd31c92b4d7dbd94360f0a2753c1e"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.14.tar.gz"
      sha256 "2b57d8994fe105bdafb4ac7454542776dcad595051eff19061f24e05ca71c969"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.14/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba938da854e5e56899edb92dc939f93aafc6f992862af0f7319a0e1a5f16b9d3"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.14/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8734efb80e2cfc601164aa3e0d24b3791cd29c0a12fdb46ed59c7bf1bd6c8abf"
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
