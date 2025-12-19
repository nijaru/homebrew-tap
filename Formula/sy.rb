class Sy < Formula
  desc "Modern rsync alternative - Fast, parallel file synchronization"
  homepage "https://github.com/nijaru/sy"
  version "0.2.0"
  license "MIT"
  head "https://github.com/nijaru/sy.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/nijaru/sy/releases/download/v0.2.0/sy-aarch64-apple-darwin.tar.gz"
      sha256 "297b9f38da029c7ae829348153a1150b7086024b911b796dcad5ecad52679d23"
    end

    on_intel do
      # No prebuilt binary for Intel yet - build from source
      url "https://github.com/nijaru/sy/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "119432a90d398c215da20abccf3b06c170b143e3bed45da7c5fd5df0e43266c0"
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
