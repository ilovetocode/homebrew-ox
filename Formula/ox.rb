class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  url "https://github.com/ilovetocode/homebrew-ox/raw/v0.1.8/dist/ox-v0.1.8-source.tar.gz"
  sha256 "cca8d908f3a1956dae3a53d67b2e1355daeef5b5ec307a1ea083de1edbf87192"
  license "Proprietary"

  depends_on "rust" => :build
  depends_on "tmux"

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "ox 0.1.8", shell_output("#{bin}/ox --version")
  end
end
