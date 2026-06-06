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
  version "0.1.46"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440012876",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "c6dc75e812788cb01fcd20eb2bb0986386180dc5966198dce2412c585c8bf4e2"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440012877",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "692fa91b0d7c95f26442213e5995a0649e6c42f1eecbc1bdc949b6a82a8d53b4"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.46", shell_output("#{bin}/ox --version")
  end
end
