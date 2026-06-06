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
  version "0.1.52"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440120697",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "78735780128f43026399f2cde133a68f27c04a776c3ceb2e0a66da251618dfef"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/440120699",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "c9147aa4bb1d7876c5c667581f79aa381ea95c3cfea2f3a93802ef549fad8bf9"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.52", shell_output("#{bin}/ox --version")
  end
end
