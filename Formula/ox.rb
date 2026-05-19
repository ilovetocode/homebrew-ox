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
  version "0.1.23"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/424102630",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "12a247fe5fd0d6478f4f716757758e6757967b6c703ae1331d5f7b00a5fd1088"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/424102631",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "bd30f5a57e5e557197487265a037cde0974fe96d777b37362884f72a50a71975"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.23", shell_output("#{bin}/ox --version")
  end
end
