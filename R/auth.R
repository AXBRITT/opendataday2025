library(dotenv)
library(arcgisutils)

dotenv::load_dot_env()

token <- arcgisutils::auth_user(
  username = Sys.getenv("ARCGIS_USER"),
  password = Sys.getenv("ARCGIS_PASSWORD"),
  host = arcgisutils::arc_host(),
  expiration = 60
)
arcgisutils::set_arc_token(token)