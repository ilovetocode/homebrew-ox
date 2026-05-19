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
  version "0.1.22"
  license "Proprietary"

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/424046457",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "005b6b3b1e42c7b2b52d0ba3a3d99ca40d60d7a3ca9f0a58b89a93ab07a25283"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/424046461",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "17c1622bb858c09399a4c50c9c838e28a71afd0cde2d53dbe3dc2cc1ba9b7717"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.22", shell_output("#{bin}/ox --version")
  end
end
