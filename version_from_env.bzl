# Determines the version to add to the pom.xml based on an environment variable
#
# During the loading phase, this reads an environment variable and exports it as a Bazel variable named VERSION
# If the environment variable was empty or unset, VERSION is set to "non-published-SNAPSHOT" instead
# The Bazel variable is saved to a file named version.bzl

def _impl(repository_ctx):
  env_var = repository_ctx.attr.env_var
  version = repository_ctx.execute(["printenv", env_var]).stdout.rstrip()
  if len(version) == 0:
    version = "non-published-SNAPSHOT"

  repository_ctx.file("version.bzl", "VERSION = \"{}\"".format(version))
  repository_ctx.file("BUILD.bazel")

version_from_env = repository_rule(
  implementation = _impl,
  attrs = {
    "env_var": attr.string(mandatory = True)
  }
)
