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
  version "0.1.29"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429257821",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "74de2b3e30c01a68e55d9645e450a3402425c784954ee7b3cb313bc64dbd7d04"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429257820",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "61c4a7c043e6ec0730160a9e7a5dbc25c0b3e3ab5c5af3dbcd788e77d5189a8d"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.29", shell_output("#{bin}/ox --version")
  end
end
