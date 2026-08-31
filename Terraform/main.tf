resource "google_compute_instance" "ci_stack" {
  name         = "ci-teaching-kit-vm"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["ci-stack", "jenkins-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 40 # GB — Jenkins + Nexus + Tomcat images/data need real space
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral external IP — this is what makes GitHub webhooks reachable
    }
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh", {
    repo_url = var.repo_url
  })
}

# Admin access: only your own IP can reach the Jenkins/Nexus/Tomcat UIs and SSH.
# Never open these ports to 0.0.0.0/0 — that's an open invitation to anyone
# on the internet to try the default credentials.
resource "google_compute_firewall" "admin_access" {
  name    = "allow-ci-stack-admin"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "8081", "8082"]
  }

  source_ranges = [var.admin_ip]
  target_tags   = ["ci-stack"]
}

# GitHub webhook access: only GitHub's published webhook IP ranges can reach
# Jenkins' webhook endpoint on port 8080. Verify these ranges are current at
# https://api.github.com/meta before relying on this in a real deployment —
# GitHub does update them occasionally.
resource "google_compute_firewall" "github_webhook" {
  name    = "allow-github-webhook"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }

  source_ranges = [
    "140.82.112.0/20",
    "143.55.64.0/20",
    "192.30.252.0/22",
    "185.199.108.0/22",
  ]
  target_tags = ["jenkins-server"]
}