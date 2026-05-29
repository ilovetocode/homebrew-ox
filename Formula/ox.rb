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
  version "0.1.32"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/432895847",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "7c530244882735a89343fcf5dc2fca198b23722743d09b40fc19485249a6b569"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/432895849",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "3a909bc509573acb80984de5bb27c698bde9d3a662be5696250d2ee5a528c1a4"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.32", shell_output("#{bin}/ox --version")
  end
end
