setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-addon-template
  mkdir -p $TESTDIR
  export PROJNAME=test-addon-template
  export DDEV_NONINTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

health_checks() {
  ddev pull ibexa-cloud -y
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev config global --web-environment-add=IBEXA_CLI_TOKEN=
  ddev config --web-environment-add=IBEXA_PROJECT=,IBEXA_ENVIRONMENT=,IBEXA_APP=
  ddev restart >/dev/null
  health_checks
}

# bats test_tags=release
@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get rfay/ddev-ibexa-cloud with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get rfay/ddev-ibexa-cloud
  ddev config global --web-environment-add=IBEXA_CLI_TOKEN=
  ddev config --web-environment-add=IBEXA_PROJECT=,IBEXA_ENVIRONMENT=,IBEXA_APP=
  ddev restart >/dev/null
  health_checks
}
