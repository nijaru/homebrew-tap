class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.13"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.13/jb-aarch64-apple-darwin.tar.gz"
      sha256 "ac317eee17e4bc7c16e8c3217b3547916ea432a3ed695f3d9d6286bb71b79d41"
    end

    on_intel do
      url "https://github.com/nijaru/jb/archive/refs/tags/v0.0.13.tar.gz"
      sha256 "601e89f4dea5413be9260f3135fe9bc834f9cd5e3f7d9418185dcfd1f5f515be"
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.13/jb-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b742d8361690bb652855d30f4ad0d9e841a969b9ca5f932a872298edad5c6315"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.13/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "84f6746c493754e629ada0d245ed4e4776710af408d97cfbfc03dbb980197b11"
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
