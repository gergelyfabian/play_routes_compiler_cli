# Determines the version to add to the pom.xml based on an environment variable

def _impl(repository_ctx):
  env_var = repository_ctx.attr.env_var
  version = repository_ctx.execute(["printenv", env_var]).stdout.rstrip()
  if len(version) == 0:
    version = "non-published-SNAPSHOT"

  repository_ctx.file("version.bzl", "VERSION = \"{}\"".format(version))

  repository_ctx.file("BUILD.bazel", """
filegroup(
  name = "version_from_file",
  srcs = ["version.bzl"],
  visibility = ["//visibility:public"]
)
  """)

version_from_env = repository_rule(
  implementation = _impl,
  attrs = {
    "env_var": attr.string(mandatory = True)
  }
)
