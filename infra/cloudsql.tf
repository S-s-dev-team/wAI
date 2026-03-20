resource "google_sql_database_instance" "postgres" {
  name             = var.db_instance_name
  database_version = "POSTGRES_16"
  region           = var.region

  deletion_protection = false

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled = false
    }

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "all-ips"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "app" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "app" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}
