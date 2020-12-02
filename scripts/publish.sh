#! /bin/bash -e
##
## Build and deploy the play routes compiler jar

artifactId="$(printenv COMPILER_CLI_ARTIFACT_ID)"
version="$(printenv COMPILER_CLI_VERSION)"
if [ -z "$artifactId" ] || [ -z "$version" ]; then
  echo "Either the artifactId or the version is not defined. Aborting publish to Maven."
  exit 1
fi

# If the version is a commit hash, do a snapshot release (i.e. if tag is <id>--<sha>)
if [[ $version =~ ^[0-9|a-f|A-F]{40}$ ]]; then
	release_type="snapshot"
else
	release_type="release"
fi

# Build package
bazel clean --expunge
bazel run //play-routes-compiler:deploy-maven --define version=$version -- $release_type --gpg

echo "Deployment complete."
