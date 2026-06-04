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
  version "0.1.37"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/438573027",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "475de26d55e75b31ddfb8f8566d3e1b3256c7f8228d349eb201cea3be6163ab8"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/438573026",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "b9deb12f2165e91b9ad1e1d875605ee10aab969b6613bd46a627af2f13ac190a"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.37", shell_output("#{bin}/ox --version")
  end
end
