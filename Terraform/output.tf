output "vm_external_ip" {
  description = "Public IP address of the CI/CD VM"
  value = google_compute_instance.ci_stack.network_interface[0].access_config[0].nat_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value = "http://${google_compute_instance.ci_stack.network_interface[0].access_config[0].nat_ip}:8080"
}

output "nexus_url" {
  description = "Nexus Repository URL"
  value = "http://${google_compute_instance.ci_stack.network_interface[0].access_config[0].nat_ip}:8081"
}

output "github_webhook_url" {
  description = "GitHub webhook URL for Jenkins"
  value = "http://${google_compute_instance.ci_stack.network_interface[0].access_config[0].nat_ip}:8080/github-webhook/"
}

output "api_url" {
  description = "API Service URL"
  value = "http://${google_compute_instance.ci_stack.network_interface[0].access_config[0].nat_ip}:3000"
}