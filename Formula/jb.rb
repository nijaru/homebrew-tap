class Jb < Formula
  desc "Background job manager for AI agents"
  homepage "https://github.com/nijaru/jb"
  version "0.0.13"
  license "MIT"
  head "https://github.com/nijaru/jb.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/jb/releases/download/v0.0.13/jb-aarch64-apple-darwin.tar.gz"
      sha256 "6774ace92521669703a2711d3353c23dd3c016a82e4897154eb30dc59aef4d9a"
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
      sha256 "30da0550bf59f59262460399bfb587d09047e05ec8771090b1bbcf6bfba57de9"
    end

    on_intel do
      url "https://github.com/nijaru/jb/releases/download/v0.0.13/jb-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3999ad2d52ae60864c9e6de216499b079fe89d94b7baf4bb74148688e7be3599"
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
