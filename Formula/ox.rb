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
  version "0.1.34"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434391406",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "284afc4e3390abe7b1eeb2ad96b4925a68757cc8230a9a943c8080ab8997e01d"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434391408",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "c07e1d5745e596f7dc17584e17dd597cefc83e83c759ab4ad5783d6eed8a5960"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.34", shell_output("#{bin}/ox --version")
  end
end
