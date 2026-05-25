require "download_strategy"
require "utils/github"

class GitHubPrivateReleaseAssetDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    token = GitHub::API.credentials
    raise CurlDownloadStrategyError.new(url, GitHub::API::NO_CREDENTIALS_MESSAGE) if token.blank?

    meta[:headers] = [
      *meta.fetch(:headers, []),
      "Accept: application/octet-stream",
      "Authorization: Bearer #{token}",
    ]

    super
  end
end

class Ox < Formula
  desc "Tmux-first CLI for managing agent sessions"
  homepage "https://github.com/ilovetocode/ox"
  version "0.1.30"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429266821",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "92acf86bf39348941b9916d25108e158dc3ef097d47a730e4b81e1749033917d"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429266819",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "34eed11a8d21653bf53476e0b900c89893903bef32d7526d9a3bbca4c7a38fbd"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.30", shell_output("#{bin}/ox --version")
  end
end
