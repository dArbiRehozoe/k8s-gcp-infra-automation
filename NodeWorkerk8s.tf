variable "instance_count" {
  default = 2
}
variable "base_instance_name" {
  default = "nodeworker"
}
resource "google_compute_instance" "nodeworker" {
  count = var.instance_count

  name         = "${var.base_instance_name}${count.index + 1}"
  hostname                  = var.hostnamenodeworker
  machine_type              = var.ci_runner_instance_type
  project                   = var.gcp_project
  zone                      = var.gcp_zone

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  boot_disk {
    initialize_params {
      image = var.image
      size  = 20
      type  = "pd-standard"
    }
  }
  labels = {
    environment = "nodeworker"
  }
  metadata = {
    enable-oslogin = "TRUE"
  }
  
  tags = ["http-server", "https-server", "lb-health-check"]

  network_interface {
    network = "default" 
    access_config {
      // Include this section to give the VM an external ip address
    }
  }
}