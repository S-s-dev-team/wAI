data "google_project" "current" {}

# Cloud Run 用サービスアカウント
resource "google_service_account" "cloudrun" {
  account_id   = "wai-cloudrun-sa"
  display_name = "wAI Cloud Run service account"
}

# Cloud SQL Client ロール
resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudrun.email}"
}

# Secret Manager アクセス権限
resource "google_secret_manager_secret_iam_member" "gemini_api_key_accessor" {
  secret_id = google_secret_manager_secret.gemini_api_key.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloudrun.email}"
}

resource "google_secret_manager_secret_iam_member" "db_password_accessor" {
  secret_id = google_secret_manager_secret.db_password.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.cloudrun.email}"
}
