class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.21/ox-v0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "6fb825d83cae44aa841d458f8eafffb3f0b61345303b32126bf0317757d095cb"
    else
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.21/ox-v0.1.21-x86_64-apple-darwin.tar.gz"
      sha256 "4b977d85b16cf460387359650a49d9731a54178e7ae1f969191f6c9ef19e928a"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.21", shell_output("#{bin}/ox --version")
  end
end
