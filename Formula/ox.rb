class Ox < Formula
  desc "tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.2/ox-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08b39e4380c8d077e7971e3fc34b2db6668e3368a66363acd5eb2bfa960eb3b2"
    else
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.2/ox-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24214b73ab17da72b800075ab95d325993c9414d05f38600e040936432a2e314"
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.2/ox-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "261ca11423e823e44396107f15bd99f5a99eae1fd39718c75e72a76cd63cf7bc"
    else
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.2/ox-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "f7865a01ec3ddfd93979acd1eabb415f3b14b17639a480a8cc1590fccb362d59"
    end
  end

  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox", shell_output("#{bin}/ox --version")
  end
end
