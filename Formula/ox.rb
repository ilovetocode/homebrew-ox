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
  url "https://api.github.com/repos/ilovetocode/ox/releases/assets/444560520",
      using: GitHubPrivateReleaseAssetDownloadStrategy
  version "0.1.68"
  sha256 "6d11e28947cb15a5bd0e01c7e2eb795c80af166b9d67f2be7818388f6edd3473"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.68", shell_output("#{bin}/ox --version")
  end
end
