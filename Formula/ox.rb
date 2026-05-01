class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.9/ox-v0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "254c50ccb9610567e9493df2c18ce102ac0358d04fadfcc9efac9602af75702b"
    else
      url "https://github.com/ilovetocode/ox/releases/download/v0.1.9/ox-v0.1.9-x86_64-apple-darwin.tar.gz"
      sha256 "e77564d90e49dea8403da2692fcb539f4e45e53ae4c5c0f34c25733e246e919b"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.9", shell_output("#{bin}/ox --version")
  end
end
