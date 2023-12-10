use zkwasm_rust_sdk::jubjub::BabyJubjubPoint;
use zkwasm_rust_sdk::jubjub::JubjubSignature;
use zkwasm_rust_sdk::wasm_output;
use zkwasm_rust_sdk::wasm_input;
use primitive_types::U256;

use wasm_bindgen::prelude::*;

use sha2::{Sha256, Digest};

#[wasm_bindgen]
pub fn zkmain() -> i64 {
    let mut hasher = Sha256::new();
    let msghash = unsafe {[
        wasm_input(1),
        wasm_input(1),
        wasm_input(1),
        wasm_input(1),
    ]};

    hasher.update(msghash[0].to_be_bytes());
    hasher.update(msghash[1].to_be_bytes());
    hasher.update(msghash[2].to_be_bytes());
    hasher.update(msghash[3].to_be_bytes());

    zkwasm_rust_sdk::dbg!("test");

    let pk = unsafe {BabyJubjubPoint {
        x: U256([
                wasm_input(0),
                wasm_input(0),
                wasm_input(0),
                wasm_input(0),
        ]),
        y: U256([
                wasm_input(0),
                wasm_input(0),
                wasm_input(0),
                wasm_input(0),
        ]),
    }};
    hasher.update(pk.x.0[0].to_be_bytes());
    hasher.update(pk.x.0[1].to_be_bytes());
    hasher.update(pk.x.0[2].to_be_bytes());
    hasher.update(pk.x.0[3].to_be_bytes());
    let sig = unsafe {JubjubSignature {
        sig_r: BabyJubjubPoint {
            x: U256([
                    wasm_input(0),
                    wasm_input(0),
                    wasm_input(0),
                    wasm_input(0),
            ]),
            y: U256([
                    wasm_input(0),
                    wasm_input(0),
                    wasm_input(0),
                    wasm_input(0),
            ]),
        },
        sig_s: [
            wasm_input(0),
            wasm_input(0),
            wasm_input(0),
            wasm_input(0),
        ]
    }};
    sig.verify(&pk, &msghash);

    let result = hasher.finalize();
    let result_u64 = [
        u64::from_be_bytes(result[0..8].try_into().unwrap()),
        u64::from_be_bytes(result[8..16].try_into().unwrap()),
        u64::from_be_bytes(result[16..24].try_into().unwrap()),
        u64::from_be_bytes(result[24..32].try_into().unwrap()),
    ];
    unsafe {
        wasm_output(result_u64[0]);
        wasm_output(result_u64[1]);
        wasm_output(result_u64[2]);
        wasm_output(result_u64[3]);
    }
    0
}
