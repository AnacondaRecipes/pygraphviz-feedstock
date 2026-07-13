#!/bin/bash
set -euxo pipefail

# Tell pygraphviz's setup.py exactly where conda's graphviz install lives.
export GRAPHVIZ_PREFIX="${PREFIX}"

export LDFLAGS="${LDFLAGS:-} -Wl,-rpath,${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib/graphviz"

if [[ "$(uname)" == "Darwin" ]]; then
  export SDKROOT="${CONDA_BUILD_SYSROOT:-$(xcrun --sdk macosx --show-sdk-path)}"
  export CFLAGS="${CFLAGS:-} -isysroot ${SDKROOT}"
  export CPPFLAGS="${CPPFLAGS:-} -isysroot ${SDKROOT}"
  export CXXFLAGS="${CXXFLAGS:-} -isysroot ${SDKROOT}"
  # macOS uses -rpath the same way via clang, so LDFLAGS above already covers it.
fi

${PYTHON} -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vv