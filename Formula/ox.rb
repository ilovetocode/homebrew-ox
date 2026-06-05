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
  version "0.1.45"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439569403",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "a834580708efd85bfd991c08588e33c1091bc68944fc3f6b763cbe45e06ca1a2"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/439569408",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "7f35f8d816254698e370c7729f85ef434c1bac2e53f9b65bb896907c9840033c"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.45", shell_output("#{bin}/ox --version")
  end
end
