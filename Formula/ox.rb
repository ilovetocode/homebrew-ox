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
  url "https://api.github.com/repos/ilovetocode/ox/releases/assets/442845136",
      using: GitHubPrivateReleaseAssetDownloadStrategy
  version "0.1.65"
  sha256 "278fb09ab8d7aa01aeb175cc7cbe311087b7c4d6de365eba1e60602640791881"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.65", shell_output("#{bin}/ox --version")
  end
end
