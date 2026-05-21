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
  version "0.1.27"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/425934404",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "9b0cba27bdf07f26f3d36c27863a9f59ba35a9eaae73784cc189c6b37e67db74"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/425934405",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "7862cc12c3aea412e5fc6e2d852af7d10ccf668a63b5a72e0d8aa3ba4dd96982"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.27", shell_output("#{bin}/ox --version")
  end
end
