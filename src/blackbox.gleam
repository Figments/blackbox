import gleam/option.{type Option, None}
import gleam/pgo

pub type BlackBox {
  BlackBox(db: AnyDatabase, config: Option(Config))
}

pub type AnyDatabase {
  Postgres(conn: pgo.Connection)
}

pub type Config {
  Config(database: String, url: Option(String))
}

pub type IpVersion {
  Ipv4
  Ipv6
}

pub fn pg_default() {
  let pg_config =
    pgo.Config(
      ..pgo.default_config(),
      database: "blackbox",
      host: "localhost",
      pool_size: 15,
    )

  BlackBox(db: Postgres(pgo.connect(pg_config)), config: None)
}

pub fn main() {
  let blackbox = pg_default()
  let db = blackbox.db.conn
}
