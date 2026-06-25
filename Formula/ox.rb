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
  url "https://api.github.com/repos/ilovetocode/ox/releases/assets/457453426",
      using: GitHubPrivateReleaseAssetDownloadStrategy
  version "0.1.79"
  sha256 "f4eb5ed98e34c824d2298e94eab45d4ae52b17686235022c96f2b9a262b7799f"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.79", shell_output("#{bin}/ox --version")
  end
end
