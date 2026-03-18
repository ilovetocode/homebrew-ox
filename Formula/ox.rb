class Ox < Formula
  desc "tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.6/ox-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e942f7af6d9be4b19ac9143b96bf2cfa46fd8231e556227cfcdf0c61bade3396"
    else
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.6/ox-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ece8b371a4208613e7bda303db1a0b86202b54d4e746a190b0442338d07cab15"
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.6/ox-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "aa9698142770603af08628cd6f0de7dc600d65f0fd9491f91c77e5f3e163be48"
    else
      url "https://github.com/ilovetocode/homebrew-ox/releases/download/v0.1.6/ox-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "65640395b2f55741a37c2a42f10a1f0bc96c1664e17409047863638ebfdb3e45"
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
