class Sy < Formula
  desc "Modern rsync alternative - Fast, parallel file synchronization"
  homepage "https://github.com/nijaru/sy"
  version "0.0.55"
  license "MIT"
  head "https://github.com/nijaru/sy.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/sy/releases/download/v0.0.55/sy-aarch64-apple-darwin.tar.gz"
      sha256 "dc85709c1d202b735048f55ab8ea19bd3cda778db542a161577881b574bca0a9"
    end

    on_intel do
      # No prebuilt binary for Intel yet - build from source
      url "https://github.com/nijaru/sy/archive/refs/tags/v0.0.55.tar.gz"
      sha256 "42c9a266b7679a5c4606448c039b49a8c613e05e96b98f289877111b2f437d4f"
      depends_on "rust" => :build
    end
  end

  def install
    if File.exist?("sy") && File.exist?("sy-remote")
      # Prebuilt binaries (Apple Silicon)
      bin.install "sy"
      bin.install "sy-remote"
    else
      # Build from source (Intel Mac)
      system "cargo", "install", *std_cargo_args
      bin.install "target/release/sy-remote" if File.exist?("target/release/sy-remote")
    end
  end

  test do
    # Test basic functionality
    system bin/"sy", "--version"

    # Test that sy can display help
    assert_match "Modern rsync alternative", shell_output("#{bin}/sy --help")

    # Test local sync
    (testpath/"source").mkpath
    (testpath/"source/test.txt").write("test content")
    system bin/"sy", testpath/"source", testpath/"dest"
    assert_predicate testpath/"dest/test.txt", :exist?
    assert_equal "test content", (testpath/"dest/test.txt").read
  end
end
