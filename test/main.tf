provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCRN2PcKYHrM5Q0IK5p12fHUduw3I3MBgnJMeS1YTALSEhaE7x92ecWFmU8BzHbB7iOwosU47f3tvJNIyTDv02zCsUH9vGmmpHcGB0EOBIxXtERTsbDbL6L43O8XORVkb9hds/9D0fvmA2MD6BQDM0UryKZncUPfC3GAbqyZjkPCh4RUalWgpvuMKIS+F5WE64+faBd0Zq9udcgIBdinzwAZY9/f6Lkz4Y+IL2GXgsRw+INp8jiaLlx1OMAlb2o69Iur/eebT9W+sVcKV9bF4gPamfDjBRdSQMZfJ8iuMxmiZ0yn+VN2O14YhrHujlxnuO0+z2GbfedVqSXfSMwNAcj"
}

module "vault-starter" {
  source                = "./.."
  allowed_inbound_cidrs = ["107.159.87.170/32"]
  vpc_id                = "vpc-121a0468"
  vault_version         = "1.6.1"
  vault_binary_bucket   = "ncabatoff-vault-binaries"
  vault_binary_name     = "vault-d4b295baf7f63294450d47aebf98a2cc4bfd50e5.gz"
  owner                 = "ncabatoff"
  name_prefix           = "ncabatoff"
  key_name              = "deployer-key"
  elb_internal          = false
  vault_cluster_version = "0.0.6"
  vault_nodes = 3
}

output "vault_address" {
  value = module.vault-starter.vault_address
}
