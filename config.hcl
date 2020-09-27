ui = true
storage "file" {
  path = "/opt/vault/vault-data"
}
listener "tcp" {
 address     = "0.0.0.0:8200"
 tls_cert_file = "/etc/vault/certs.crt"
 tls_key_file  = "/etc/vault/certs.key"
}
disable_mlock = false
api_addr = "http://localhost:8200"

