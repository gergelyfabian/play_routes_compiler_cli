#! /bin/bash -e
##
## Build and deploy the play routes compiler jar

artifactId="$(printenv COMPILER_CLI_ARTIFACT_ID)"
version="$(printenv COMPILER_CLI_VERSION)"
if [ -z "$artifactId" ] || [ -z "$version" ]; then
  echo "Either the artifactId or the version is not defined. Aborting publish to Maven."
  exit 1
fi

# Open issue: https://github.com/graknlabs/bazel-distribution/issues/230
if [[ $version =~ .*SNAPSHOT$ ]]; then
	echo "SNAPSHOT deployments are not currently supported."
fi

# Build and deploy package
bazel clean --expunge
bazel run //play-routes-compiler:deploy-maven --define version=$version -- release --gpg

echo "Deployment complete."
