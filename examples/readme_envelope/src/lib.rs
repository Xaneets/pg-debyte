use pg_debyte_core::{BincodeCodec, DecodeError, StaticRegistry};
use pg_debyte_macros::declare_decoder;
use pgrx::prelude::*;
use pgrx::JsonB;
use serde::{Deserialize, Serialize};
use uuid::Uuid as CoreUuid;

pg_module_magic!();

#[derive(Debug, Deserialize, Serialize)]
struct MyRecord {
    id: u32,
    label: String,
}

const MY_TYPE_ID: CoreUuid = CoreUuid::from_bytes([0x11; 16]);
const MY_SCHEMA_VERSION: u16 = 1;
const MY_CODEC_ID: u16 = 1;
const MY_CODEC: BincodeCodec = BincodeCodec::new(MY_CODEC_ID, 32 * 1024 * 1024);

declare_decoder!(
    MY_DECODER,
    ty = MyRecord,
    type_id = MY_TYPE_ID,
    schema_version = MY_SCHEMA_VERSION,
    codec = MY_CODEC,
    codec_ty = BincodeCodec,
    actions = []
);

static REGISTRY: StaticRegistry = StaticRegistry::new(&[&MY_DECODER], &[]);

#[pg_guard]
pub unsafe extern "C-unwind" fn _PG_init() {
    pg_debyte_pgrx::init_gucs();
    pg_debyte_pgrx::set_registry(&REGISTRY);
}

#[pg_extern]
fn bytea_to_json_auto(data: Vec<u8>) -> Result<JsonB, DecodeError> {
    let limits = pg_debyte_pgrx::limits();
    let value = pg_debyte_pgrx::decode_auto(&data, &limits)?;
    Ok(JsonB(value))
}
