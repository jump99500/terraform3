variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "name" {
  type    = string
  default = "ssw"
}

variable "key" {
  type    = string
  default = "ssw1-key"
}

variable "ava_zone" {
  type    = list(any)
  default = ["a", "c"]
}

variable "cidr_main" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pub_sub" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.1.0/24"] #여러 개를 사용할 때는 대괄호를 사용 
}

variable "pri_sub" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "pri_subdb" {
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "cidr_route" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cidr_routev6" {
  type    = string
  default = "::/0"
}

variable "ssh" {
  type    = string
  default = "ssh"
}

variable "http" {
  type    = string
  default = "http"
}

variable "icmp" {
  type    = string
  default = "icmp"
}

variable "mysql" {
  type    = string
  default = "mysql"
}

variable "port_ssh" {
  type    = number
  default = 22
}

variable "port_http" {
  type    = number
  default = 80
}

variable "Port_mysql" {
  type    = number
  default = 3306
}

variable "port_zero" {
  type    = number
  default = 0
}

variable "minus" {
  default = -1
}

variable "pro_tcp" {
  type    = string
  default = "tcp"
}

variable "pro_icmp" {
  type    = string
  default = "icmp"
}

variable "pro_udp" {
  type    = string
  default = "udp"
}

variable "nul" {
  default = null
}

variable "protocol" {
  default = "HTTP"
}

