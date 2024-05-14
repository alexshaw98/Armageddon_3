/*  EURO NETWORK  */
resource google_compute_network euro-vpc-tf {
  name                    = "euro-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource google_compute_subnetwork euro-subnet-tf {
  name          = "euro-subnet-tf"
  network       = google_compute_network.euro-vpc-tf.self_link
  ip_cidr_range = "10.187.13.0/24"
  region        = "europe-west1"
}

resource "google_compute_firewall" "http-traffic" {
  network     = google_compute_network.euro-vpc-tf.name
  name        = "http-traffic"
  direction   = "INGRESS"  
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}


/*  ASIA NETWORK  */
resource google_compute_network asia-vpc-tf {
  name                    = "asia-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource google_compute_subnetwork asia-subnet-tf {
  name          = "asia-subnet-tf"
  network       = google_compute_network.asia-vpc-tf.self_link
  ip_cidr_range = "192.168.13.0/24"
  region        = "asia-southeast1"
}

resource google_compute_firewall asia-rdp-traffic-tf {
  network     = google_compute_network.asia-vpc-tf.name
  name        = "asia-rdp-traffic-tf"
  direction   = "INGRESS"  
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
}




/*  US NETWORK  */
resource google_compute_network us-vpc-tf {
  name                    = "us-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource google_compute_subnetwork us-subnet1-tf {
  name          = "us-subnet1-tf"
  network       = google_compute_network.us-vpc-tf.self_link
  ip_cidr_range = "172.16.13.0/24"
  region        = "us-central1"
}

resource google_compute_subnetwork us-subnet2-tf {
  name          = "us-subnet1-tf"
  network       = google_compute_network.us-vpc-tf.self_link
  ip_cidr_range = "172.16.85.0/24"
  region        = "us-east1"
}

resource google_compute_firewall us-rdp-traffic-tf {
  network     = google_compute_network.us-vpc-tf.name
  name        = "us-rdp-traffic-tf"
  direction   = "INGRESS"  
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
}