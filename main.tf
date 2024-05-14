# Create Euro Web Server
resource "google_compute_instance" "euro-web-server" {
  machine_type = "e2-medium"
  name         = "euro-web-server"
  zone         = "europe-west1-b"
  metadata     = {
  startup-script = file("remo_script.sh")
}
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    subnetwork = google_compute_subnetwork.euro-subnet-tf.self_link
    network    = google_compute_network.euro-vpc-tf.self_link
  }
}

# Create US Virtual Machine Instance 1
resource "google_compute_instance" "us-vm-instance1" {
  machine_type = "e2-medium"
  name         = "us-vm-instance1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }
  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    subnetwork = google_compute_subnetwork.us-subnet1-tf.self_link
    network    = google_compute_network.us-vpc-tf.self_link
  }
}

# Create US Virtual Machine Instance 2
resource "google_compute_instance" "us-vm-instance2" {
  machine_type = "e2-medium"
  name         = "us-vm-instance2"
  zone         = "us-east1-b"
  boot_disk{
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }
  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    subnetwork = google_compute_subnetwork.us-subnet2-tf.self_link
    network    = google_compute_network.us-vpc-tf.self_link
  }
}

# Create Asian Virtual Machine Instance
resource "google_compute_instance" "asia-vm-instance" {
  machine_type = "e2-medium"
  name         = "asia-vm-instance"
  zone         = "asia-southeast1-a"
  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }
  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    subnetwork = google_compute_subnetwork.asia-subnet-tf.self_link
    network    = google_compute_network.asia-vpc-tf.self_link
  }
}