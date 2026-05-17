class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.20/ox-v0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "708575a0658f84d6919450f58b57299829e689a2ed520292714dc0d33b63866e"
    else
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.20/ox-v0.1.20-x86_64-apple-darwin.tar.gz"
      sha256 "85c654671fb9046e44883757bb21919dff154def04b68152482a8aec2b33af40"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.20", shell_output("#{bin}/ox --version")
  end
end
