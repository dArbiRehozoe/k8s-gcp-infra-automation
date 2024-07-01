data "google_client_openid_userinfo" "me" {
}

resource "google_os_login_ssh_public_key" "add_my_key" {
  project = var.gcp_project
  user =  data.google_client_openid_userinfo.me.email
  key = file("~/.ssh/id_rsa.pub")
}

resource "google_service_account" "service_account" {
  account_id   = "terraform"
  display_name = "terraform"
}
resource "google_service_account_key" "service_account" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
resource "local_file" "service_account" {
    content  = base64decode(google_service_account_key.service_account.private_key)
    filename = "./service_account.json"
}
resource "google_project_iam_binding" "project" {
  project = var.gcp_project
  role    = "roles/viewer"

  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}

resource "null_resource" "ansible_trigger" {
  # Dépendez des instances pour garantir l'exécution après leur création
  depends_on = [
    google_compute_instance.nodemaster,
    google_compute_instance.nodeworker[0],
    google_compute_instance.nodeworker[1],
  ]

  # Exécutez Ansible après la création des instances
  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook playbook.yml"
  }
}
output "ip" {
  value = google_compute_instance.nodemaster.network_interface.0.access_config.0.nat_ip
}