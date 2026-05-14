class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.16/ox-v0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "a18c69c80b2a377d843432e69c649222db4e1e943b7fb8d78ddaf7d27135fa3e"
    else
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.16/ox-v0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "ca763e2fcc633fec2f7617ebdc86aa5f459609a1e1b8d3aedfd186324eb07c13"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.16", shell_output("#{bin}/ox --version")
  end
end
