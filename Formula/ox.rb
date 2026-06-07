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
  url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440802462",
      using: GitHubPrivateReleaseAssetDownloadStrategy
  version "0.1.62"
  sha256 "0ac3c52776fb826ba85f7b5f02e3f2e5b3730c83460cd9a896d030304989f316"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on "tmux"

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.62", shell_output("#{bin}/ox --version")
  end
end
