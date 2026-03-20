resource "google_artifact_registry_repository" "docker" {
  location      = var.region
  repository_id = "wai-app"
  format        = "DOCKER"
  description   = "Docker images for wAI"
}
