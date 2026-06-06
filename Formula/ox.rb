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
  version "0.1.50"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440103715",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "6681b108884a7d3ca8a76a40eecae3ba4413f8e66f91cd87d22077979d6239d3"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440103714",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "e126a937393c2699037f0314d9b4669df98202e0accf293c2905bedb3ca0caf9"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.50", shell_output("#{bin}/ox --version")
  end
end
