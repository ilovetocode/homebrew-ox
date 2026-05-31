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
  version "0.1.36"
  license :cannot_represent

  depends_on "tmux"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434525537",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "773f04dacc7987b8aab9cdec97e285f72c7404216dfdabdfc2f3fc165a85b5df"
    else
      url "https://api.github.com/repos/ilovetocode/ox/releases/assets/434525538",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "c28b7665b3a79752b8cd691023cbd4877bd30496f0bca8a68aff709112ab74ef"
    end
  end

  def install
    bin.install "ox"
  end

  test do
    assert_match "ox 0.1.36", shell_output("#{bin}/ox --version")
  end
end
