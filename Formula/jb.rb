class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.9"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.9/jb-aarch64-apple-darwin.tar.gz"
      sha256 "4199a0aa7c820010b2a687a53bb819c09fa819cb8fd7601cac21e8ffed34f301"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.9.tar.gz"
      sha256 "9a432506a2de0808fddfe99361db935696948b7156634125e8a547e068636a7c"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.9/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c212cabe9c6b3157c14e7dc19c82a888ebf640c06c999bbdd3d6752a575262d"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.9/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc059b004c82223765735b02711cd94826d646908ce7ddbe6a9fe1173b3daafa"
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
