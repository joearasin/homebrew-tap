class Colima < Formula
  desc "Container runtimes with configurable XFS data disk support"
  homepage "https://github.com/joearasin/colima"

  url "https://github.com/joearasin/colima.git",
      tag:      "v0.10.3-xfs.1",
      revision: "91fe8d486645cc7735f58f7261addfbce9c33d6e"

  version "0.10.3-xfs.1"
  license "MIT"

  depends_on "go" => :build
  depends_on "lima"

  def install
    project = "github.com/abiosoft/colima"
    ldflags = %W[
      -X #{project}/config.appVersion=#{version}
      -X #{project}/config.revision=#{Utils.git_head}
    ]

    system "go", "build", *std_go_args(ldflags:), "./cmd/colima"
    generate_completions_from_executable bin/"colima",
      shell_parameter_format: :cobra
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/colima version 2>&1")
  end
end
