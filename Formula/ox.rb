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
  version "0.1.39"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439355119",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "a01f93105be601e77c6d58cb4df1e31d32aa22fa3eb685ba461e1fa3591e68ed"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439355116",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "be6deb7f0e0aa1d2a1ba707b23efc0e775db4d764504c4ff9049c9a06e3f7532"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.39", shell_output("#{bin}/ox --version")
  end
end
