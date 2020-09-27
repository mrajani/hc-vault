ui = true
storage "file" {
  path = "/opt/vault/vault-data"
}
listener "tcp" {
 address     = "0.0.0.0:8200"
 tls_disable = 1
}
disable_mlock = false
api_addr = "http://localhost:8200"

