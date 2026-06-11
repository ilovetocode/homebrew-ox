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
  url "https://api.github.com/repos/ilovetocode/ox/releases/assets/444615513",
      using: GitHubPrivateReleaseAssetDownloadStrategy
  version "0.1.69"
  sha256 "a9a87a19ddcfcb1f94c25b1b35920e8a0f22a2bb9e45ffdb2c6f31529098e88c"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.69", shell_output("#{bin}/ox --version")
  end
end
