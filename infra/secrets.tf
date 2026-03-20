resource "google_secret_manager_secret" "gemini_api_key" {
  secret_id = "wai-gemini-api-key"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "gemini_api_key" {
  secret      = google_secret_manager_secret.gemini_api_key.id
  secret_data = var.gemini_api_key
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = "wai-db-password"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password
}
