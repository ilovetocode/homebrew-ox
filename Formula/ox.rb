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
  version "0.1.35"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434412965",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "44dc541d8b9c9f493dd6183ff0be1d2bcd3da27a048db63984a1e97a26adf80a"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434412962",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "9cf7cdd2c0f2957e5b6733e25cc5e0ac0faf9616132a1bddc1a3d4e4a91fe580"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.35", shell_output("#{bin}/ox --version")
  end
end
