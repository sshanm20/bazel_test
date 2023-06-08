load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "rules_cc",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.6/rules_cc-0.0.6.tar.gz"],
    sha256 = "3d9e271e2876ba42e114c9b9bc51454e379cbf0ec9ef9d40e2ae4cec61a31b40",
    strip_prefix = "rules_cc-0.0.6",
)

http_archive(
    name = "bazel_skylib",
    sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()


git_repository(
    name = "oem_ford",
    branch = "feature/single_build_v710",
    build_file = "//:cluster-platform/turing/fbl/oem_ford/oem_ford.BUILD",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/turing/fbl/oem_ford",
)

git_repository(
    name = "bsw-gen",
    build_file = "//:programs/ford/my2023/v710/bsw-gen/bsw-gen.BUILD",
    commit = "4d1d5aaec500514f203969d9f3dd8fb7edecddb1",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/programs/ford/my2023/v710/bsw-gen",
)

git_repository(
    name = "bl-app",
    build_file = "//:programs/ford/vcar/bl-app/bl-app.BUILD",
    commit = "1139ebdd276207408ef8c0b1822d7fcd7c535d2a",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/programs/ford/vcar/bl-app",
)

git_repository(
    name = "ucl",
    build_file = "//:platform/bsp-os/dijkstra/infrastructure/ucl/ucl.BUILD",
    commit = "7b23d6c9e8e0ae6c0c5520151ab3326fdbebb01c",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/dijkstra/infrastructure/ucl",
)

git_repository(
    name = "wdgm",
    build_file = "//:cluster-platform/turing/vautosar/sys/wdgm/wdgm.BUILD",
    commit = "a1424a4c0809c8ac7583d8ddf536e67e1b3ad391",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/turing/vautosar/sys/wdgm",
)

git_repository(
    name = "bl-ucl-gen",
    build_file = "//:programs/ford/vcar/bl-ucl-gen/bl-ucl-gen.BUILD",
    commit = "469ac301331cdd0d622893d49c3ce05056dfb324",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/programs/ford/vcar/bl-ucl-gen",
)

git_repository(
    name = "bl-build",
    build_file = "//:programs/ford/my2023/v710/bl-build/bl-build.BUILD",
    commit = "06fe300e92bd1c64d5b05f6d6921953a178ad1d9",
    remote = "https://bsp-os.git.visteon.com/platform/bsp-os/programs/ford/my2023/v710/bl-build",
)

git_repository(
    name = "my_custom_rules",
    # commit = "cd56aea33566ca5abe02702e3e3f261b105b5944",
    commit = "9c5adc5a79a3abe3bbd38e62f5924de94cab2dc8",
    remote = "http://10.185.4.138/bazel/configurations.git",
)

git_repository(
    name = "custom_platforms",
    build_file = "@my_custom_rules//:platforms.BUILD",
    commit = "9c5adc5a79a3abe3bbd38e62f5924de94cab2dc8",
    # commit = "cd56aea33566ca5abe02702e3e3f261b105b5944",
    remote = "http://10.185.4.138/bazel/configurations.git",
)

# new_local_repository(
#     name = "my_custom_rules",
#     path = "/mnt/c/Users/BSAIMSHU/Desktop/git_versions/configurations",
#     build_file = "/mnt/c/Users/BSAIMSHU/Desktop/git_versions/configurations/BUILD",
# )

# new_local_repository(
#     name = "custom_platforms",
#     path = "/mnt/c/Users/BSAIMSHU/Desktop/git_versions/platforms",
#     build_file = "/mnt/c/Users/BSAIMSHU/Desktop/git_versions/configurations/platforms.BUILD",
# )

http_archive(
    name = "my_custom_compiler",
    sha256 = "ac5fe58b257585e528d1b42939849cf98a7eb79f4fb5ef0f2a7891f65e08b7bb",
    urls = ["http://jfrog.bangalore.qa.visteon.com/artifactory/test_bazel/ghs_custom_with_config_v2.tar.xz"],
    build_file = "@my_custom_rules//:toolchain/BUILD",
    strip_prefix = "GHS_custom_with_config"
)

register_toolchains("@my_custom_compiler//...")