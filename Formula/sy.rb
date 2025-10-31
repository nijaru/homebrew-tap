class Sy < Formula
  desc "Modern rsync alternative - Fast, parallel file synchronization"
  homepage "https://github.com/nijaru/sy"
  url "https://github.com/nijaru/sy/archive/refs/tags/v0.0.55.tar.gz"
  sha256 "42c9a266b7679a5c4606448c039b49a8c613e05e96b98f289877111b2f437d4f"
  license "MIT"
  head "https://github.com/nijaru/sy.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Install sy-remote helper binary
    bin.install "target/release/sy-remote" if File.exist?("target/release/sy-remote")
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
