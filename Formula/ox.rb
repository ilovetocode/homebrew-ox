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
  version "0.1.28"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/425939347",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "187112578a478d88a2b67409d32da24883069ccc9ea017fa6182c775f7e250d1"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/425939348",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "1bcbfd4a3937148d8be5431fc7befeb4984fcf0fecdc888078ff6cf6462ffb5d"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.28", shell_output("#{bin}/ox --version")
  end
end
