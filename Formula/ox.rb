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
  version "0.1.31"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429290681",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "44f8edd5d93aea86d30a754355e9e14e44c95007dd9256da6a2966534fac4ae1"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/429290682",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "2773ab73c5d625cbb0593ae90725e061e209eaad8ff1b49172f300228c2ca6ec"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.31", shell_output("#{bin}/ox --version")
  end
end
