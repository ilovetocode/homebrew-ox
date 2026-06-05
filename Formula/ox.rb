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
  version "0.1.42"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439447821",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "55b1acc1a3468183ec98af6562507aa75c8e95b21e9bc13ed49e88a2e0ceac23"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439447824",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "57e6344cb478a9d82620d4400d41a5bae942651be77ada819541ba83077ec1f8"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.42", shell_output("#{bin}/ox --version")
  end
end
