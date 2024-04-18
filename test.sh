#!/bin/bash

set -e
set -x

rm -rf output
mkdir output

FUNC=zkmain

RUST_LOG=DEBUG ~/zkWasm/target/release/delphinus-cli -k 22 --host standard --function $FUNC --output ./output --param ./params --wasm ./pkg/output.wasm dry-run \
--public \
0x593ab9dc72e5135c1765a733828a008de9e9f9ad1b9d39a61ab401b6addd1d04:bytes-packed \
--private \
0x2dd118fa40e3f621fe0ef38bd378a2b848c7722a8f7ff7e7cab028edbf15a70a:bytes-packed \
0x7912b5c0cb0dd9c23ebd4f162959d7dcdb5e28ba5270bc3aff4eb81db8b0ff13:bytes-packed \
0x361458fab4920b65fe891584db407a3f7a7fcda2fabd102941f4747dfc82b113:bytes-packed \
0x027d0e6b2dd79d1a58488f492ac8287cab451711b40ae4082db95c15d3b79b12:bytes-packed \
0x74aa2f219b6405ad073ad2ebbafc7c861515b8405fc5e8b2fa5b09b47c1c3105:bytes-packed

#~/zkWasm/target/release/delphinus-cli -k 22 --host standard --function $FUNC --output ./output --param ./params --wasm ./pkg/output.wasm single-prove --private 2:i64

#~/zkWasm-host-circuits/target/release/zkwasm-host-circuits-prover --input external_host_table.json --opname jubjubsum --output output/ --param params
