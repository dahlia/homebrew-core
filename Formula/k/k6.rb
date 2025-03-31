class K6 < Formula
  desc "Modern load testing tool, using Go and JavaScript"
  homepage "https://k6.io"
  url "https://github.com/grafana/k6/archive/refs/tags/v0.58.0.tar.gz"
  sha256 "013c5deb43264afc2f17a2f059fa27a706464abb235af401acfda26bb45fd8e7"
  license "AGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2fa3ba542358442f674abadf5311b3df139b231ef936d22ec1353f892c68d8d7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2fa3ba542358442f674abadf5311b3df139b231ef936d22ec1353f892c68d8d7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2fa3ba542358442f674abadf5311b3df139b231ef936d22ec1353f892c68d8d7"
    sha256 cellar: :any_skip_relocation, sonoma:        "4fa3ca23db747428df4052d2b63e7feceb63a6e75f8a4b279c8772e7841c4157"
    sha256 cellar: :any_skip_relocation, ventura:       "4fa3ca23db747428df4052d2b63e7feceb63a6e75f8a4b279c8772e7841c4157"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24567bec8c95d994fe68af10802d02fee986c31d95c8e00643f31d8c07453da0"
  end

  depends_on "go" => :build

  def install
    # see comment, https://github.com/Homebrew/homebrew-core/pull/217383#issuecomment-2766058674
    odie "Revert the version check for 0.58.0" if build.stable? && version > "0.58.0"

    system "go", "build", *std_go_args(ldflags: "-s -w")

    generate_completions_from_executable(bin/"k6", "completion")
  end

  test do
    (testpath/"whatever.js").write <<~JS
      export default function() {
        console.log("whatever");
      }
    JS

    assert_match "whatever", shell_output("#{bin}/k6 run whatever.js 2>&1")

    system bin/"k6", "version"
  end
end
