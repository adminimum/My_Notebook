variable "owner" {
  type = string
  default = "Roodmin"
}
variable "Project" {
  type = string
  default = "My_notebook"
}
variable "availability_zone" {
  type = string
  default = "eu-central-1"  
}
variable "cidr_block_vpc" {
  type = string
  default = "10.10.0.0/16"  
}
variable "cidr_block_pr" {
  type = string
  default = "10.10.1.0/24"  
} 
variable "cidr_block_pub" {
  type = string
  default = "10.10.2.0/24"  
}
variable "port_of_app"{
  default = 7373
}
variable "ip_kub_master"{
  default = "10.10.1.2"
}
variable "ip_kub_node"{
  default = "10.10.1.3"
}
variable "ip_mysql"{
  default = "10.10.1.4"
}
variable "ip_web_server"{
  default = "10.10.2.2"
}
variable "ssh_key" {
  type = string
  description = "Provides custom public ssh key"
}
