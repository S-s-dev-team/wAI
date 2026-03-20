locals {
  backend_image  = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker.repository_id}/backend:${var.image_tag}"
  frontend_image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker.repository_id}/frontend:${var.image_tag}"
}

# ===== Backend (Go + Echo) =====
resource "google_cloud_run_v2_service" "backend" {
  name                = "wai-backend"
  location            = var.region
  deletion_protection = false

  template {
    service_account = google_service_account.cloudrun.email

    containers {
      image = local.backend_image

      ports {
        container_port = 8080
      }

      # DB接続
      env {
        name  = "DATABASE_HOST"
        value = google_sql_database_instance.postgres.public_ip_address
      }

      env {
        name  = "DATABASE_PORT"
        value = "5432"
      }

      env {
        name  = "DATABASE_NAME"
        value = var.db_name
      }

      env {
        name  = "DATABASE_USER"
        value = var.db_user
      }

      env {
        name = "DATABASE_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.db_password.secret_id
            version = "latest"
          }
        }
      }

      # Firebase
      env {
        name  = "FIREBASE_AUTH_PROJECT_ID"
        value = var.firebase_project_id
      }

      env {
        name  = "ALLOWED_EMAIL_DOMAINS"
        value = var.allowed_email_domains
      }

      # Gemini
      env {
        name = "GEMINI_API_KEY"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.gemini_api_key.secret_id
            version = "latest"
          }
        }
      }

      # CORS
      env {
        name  = "ALLOWED_ORIGINS"
        value = google_cloud_run_v2_service.frontend.uri
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
  }

  depends_on = [
    google_secret_manager_secret_version.gemini_api_key,
    google_secret_manager_secret_version.db_password,
  ]
}

resource "google_cloud_run_v2_service_iam_member" "backend_public" {
  name     = google_cloud_run_v2_service.backend.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# ===== Frontend (Flutter Web) =====
resource "google_cloud_run_v2_service" "frontend" {
  name                = "wai-frontend"
  location            = var.region
  deletion_protection = false

  template {
    containers {
      image = local.frontend_image

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "256Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "frontend_public" {
  name     = google_cloud_run_v2_service.frontend.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
