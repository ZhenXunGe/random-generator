#!/bin/bash

set -e
set -x

rm -rf output
mkdir output

FUNC=zkmain

~/zkWasm/target/release/delphinus-cli -k 22 --host standard --function $FUNC --output ./output --param ./params --wasm ./pkg/output.wasm dry-run \
--public  0xbd9dd0e087cc1b2ff5b39a13419ba575811761585fac8afdbc1353bf3151b9a5:bytes-packed \
--private 0x222d1a9a490f0c0a86426d8c3e2a3e6da9bc4a00e74dbf472e005be73f544519:bytes-packed \
          0x0004006e4c7d3680b8b4789b41143c257084953286b0ce5cd98ca678e07c93b2:bytes-packed \
          0x188fa8fff3f9feb3e796b7c1018a05df36a26cb26184856869d5d154985a3134:bytes-packed \
          0x0b411dfb42e25ee8abc69e63d5ac96f73e68505c601601cdcb54c18d1fc9b866:bytes-packed \
          0x0a3db164ea14effb72987cfd6f3fb53a932bfc7087db2a12dc29e8f96f65fe58:bytes-packed

#~/zkWasm/target/release/delphinus-cli -k 22 --host standard --function $FUNC --output ./output --param ./params --wasm ./pkg/output.wasm single-prove --private 2:i64

~/zkWasm-host-circuits/target/release/zkwasm-host-circuits-prover --input external_host_table.json --opname jubjubsum --output output/ --param params
