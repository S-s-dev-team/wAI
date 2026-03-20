variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "gemini_api_key" {
  type      = string
  sensitive = true
}

variable "firebase_project_id" {
  type = string
}

variable "firebase_api_key" {
  type = string
}

variable "firebase_auth_domain" {
  type = string
}

variable "allowed_email_domains" {
  type    = string
  default = ""
}

variable "db_instance_name" {
  type    = string
  default = "wai-postgres"
}

variable "db_name" {
  type    = string
  default = "wai"
}

variable "db_user" {
  type    = string
  default = "wai-app"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "image_tag" {
  type    = string
  default = "latest"
}
