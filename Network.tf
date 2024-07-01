resource "google_compute_firewall" "monitoring_firewall" {
  name    = "monitoringfirewall"
  network = "default"  # Remplacez par le nom de votre réseau

  allow {
    protocol = "tcp"
     ports    = [80,"6443","8080","6443", "2379-2380", "10250", "10251", "10252", "30000-32767"]# Port MongoDB, ajustez selon vos besoins
  }

  source_ranges = ["0.0.0.0/0"]  # Adresses IP source autorisées, ajustez selon vos besoins
  direction     = "INGRESS"
  disabled      = false
  priority      = 60000
}