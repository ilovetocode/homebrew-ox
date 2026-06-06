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
  version "0.1.47"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440055371",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "e9d7a20d4469592e13b7df76404a6a25c3e5715a8aeae4ea1ee06e1080e6efbb"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440055370",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "6008f17752ffc2b14c7c09669e663dfdb0de837791ec3aba1cb0da7bbc6d6b8d"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.47", shell_output("#{bin}/ox --version")
  end
end
