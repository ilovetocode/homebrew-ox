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
  version "0.1.44"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439558458",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "cb0957b70a3693dcaf0fd5bbf08e3b7b820935c15072da40ba22f61a7d260fd5"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439558456",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "4bd67ef8b66cff6280df3f470908afbb7ab42fe75aa4b7010445be20b91a72a4"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.44", shell_output("#{bin}/ox --version")
  end
end
