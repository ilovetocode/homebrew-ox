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
  version "0.1.41"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439370197",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "0a34b06dd5b9e166a7c0ad26d49ec009f5d2d9916eb6649af010cae542ab15fd"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439370200",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "b3a2a7bf7f4873dcbd7ecde5f11003d92978fa0d75f716ba0c8055dc3353df9a"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.41", shell_output("#{bin}/ox --version")
  end
end
