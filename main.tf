###
#   Kubernetes Umgebung
#


module "master" {

  #source     = "./terraform-lerncloud-module"
  source     = "git::https://github.com/mc-b/terraform-lerncloud-multipass"
  #source     = "git::https://github.com/mc-b/terraform-lerncloud-maas"
  #source     = "git::https://github.com/mc-b/terraform-lerncloud-lernmaas"  
  #source     = "git::https://github.com/mc-b/terraform-lerncloud-aws"
  #source     = "git::https://github.com/mc-b/terraform-lerncloud-azure" 
  #source     = "git::https://github.com/mc-b/terraform-lerncloud-proxmox"    

  module      = "virtar-${var.host_no}-${terraform.workspace}"
  description = "Virtualisierung über Cloud und Container bis Serverless (VIRTAR)"
  userdata    = "cloud-init-virtar.yaml"

  cores   = 4
  memory  = 16
  storage = 32
  # SSH, Kubernetes, NFS
  ports      = [ 22, 80, 16443, 25000 ]

  # MAAS Server Access Info
  url = var.url
  key = var.key
  vpn = var.vpn
}




