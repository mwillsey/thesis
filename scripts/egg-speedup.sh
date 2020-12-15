#!/usr/bin/env bash
set -euo pipefail


export EGG_TIME_LIMIT=3000
export EGG_NODE_LIMIT=1000000
export EGG_ITER_LIMIT=100

normal_dir=$(realpath data/normal/)
mkdir $normal_dir
upward_dir=$(realpath data/upward/)
mkdir $upward_dir

cd ~/src/egg/

export EGG_BENCH_DIR=$normal_dir
cargo test --tests --include-ignored --features "reports"                --release -- --test-threads=1 --nocapture
export EGG_BENCH_DIR=$upward_dir
cargo test --tests --include-ignored --features "reports,upward-merging" --release -- --test-threads=1 --nocapture

echo normal $normal_dir
echo upward $upward_dir
