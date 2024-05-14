#------------------------EURO Gateway (1)------------------------#
resource "google_compute_address" "europe-static-ip" {
  name   = "europe-static-ip"
  region = "europe-west1"
}

resource "google_compute_vpn_gateway" "euro-vpn-gateway" {
  name       = "euro-vpn-gateway"
  network    = google_compute_network.euro-vpc-tf.id
  region     = "europe-west1"
  depends_on = [ google_compute_subnetwork.euro-subnet-tf ]
}

#Fowarding Rule to Link Gatway to Generated IP
resource "google_compute_forwarding_rule" "rule-1-gateway" {
  name        = "rule-1-gateway"
  region      = "europe-west1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.europe-static-ip.address
  target      = google_compute_vpn_gateway.euro-vpn-gateway.self_link
}

#UPD 500 traffic Rule 2
resource "google_compute_forwarding_rule" "rule-2-500" {
  name        = "rule-2-500"
  region      = "europe-west1"
  ip_protocol = "UDP"
  ip_address  = google_compute_address.europe-static-ip.address
  port_range  = "500"
  target      = google_compute_vpn_gateway.euro-vpn-gateway.self_link
}

#UDP 4500 traffic rule 3
resource "google_compute_forwarding_rule" "rule-3-4500" {
  name        = "rule-3-4500"
  region      = "europe-west1"
  ip_protocol = "UDP"
  ip_address  = google_compute_address.europe-static-ip.address
  port_range  = "4500"
  target      = google_compute_vpn_gateway.euro-vpn-gateway.self_link
}

# Tunnel 1
resource "google_compute_vpn_tunnel" "tunnel-europe-to-asia" {
  name                    = "tunnel-europe-to-asia"
  target_vpn_gateway      = google_compute_vpn_gateway.asia-gateway-2.id
  peer_ip                 = google_compute_address.europe-static-ip.address
  shared_secret           = sensitive("secretsecret")
  ike_version             = 2
  local_traffic_selector  = ["10.187.13.0/24"]
  remote_traffic_selector = ["192.168.13.0/24"]
  depends_on = [ 
    google_compute_forwarding_rule.rule-1-gateway,
    google_compute_forwarding_rule.rule-2-500,
    google_compute_forwarding_rule.rule-3-4500
   ]
}

#Final Destination 1
resource "google_compute_route" "route1" {
  name                = "route1"
  network             = google_compute_network.asia-vpc-tf.name
  dest_range          = "10.187.13.0/24"
  priority            = 1000
    depends_on        = [google_compute_vpn_tunnel.asia-to-europe-tunnel]     
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-europe-to-asia.id

}


#------------------------ASIA Gateway (2)------------------------#
#Static IP
resource "google_compute_address" "asia-static-ip" {
  name   = "asia-static-ip"
  region = "asia-southeast1"
}


# Gateway 2
resource "google_compute_vpn_gateway" "asia-gateway-2" {
    name       = "asia-gateway-2"
    network    = google_compute_network.asia-vpc-tf.id
    region     = "asia-southeast1"
    depends_on = [ google_compute_subnetwork.euro-subnet-tf]
}


#Fowarding Rule to Link Gateway to Generated IP
resource "google_compute_forwarding_rule" "rule-4-gateway" {
  name        = "rule-4-gateway"
  region      = "asia-southeast1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.asia-static-ip.address
  target      = google_compute_vpn_gateway.asia-gateway-2.self_link
}

#UPD 500 traffic Rule
resource "google_compute_forwarding_rule" "rule-5-500" {
  name        = "rule-5-500"
  region      = "asia-southeast1"
  ip_protocol = "UDP"
  ip_address  = google_compute_address.asia-static-ip.address
  port_range  = "500"
  target      = google_compute_vpn_gateway.asia-gateway-2.self_link
}

#UDP 4500 traffic rule
resource "google_compute_forwarding_rule" "rule-6-4500" {
  name        = "rule-6-4500"
  region      = "asia-southeast1"
  ip_protocol = "UDP"
  ip_address  = google_compute_address.asia-static-ip.address
  port_range  = "4500"
  target      = google_compute_vpn_gateway.asia-gateway-2.self_link
}

# Tunnel 2
resource "google_compute_vpn_tunnel" "asia-to-europe-tunnel" {
  name                    = "asia-to-europe-tunnel"
  target_vpn_gateway      = google_compute_vpn_gateway.euro-vpn-gateway.id
  peer_ip                 = google_compute_address.asia-static-ip.address
  shared_secret           = sensitive("secretsecret")
  ike_version             = 2
  local_traffic_selector  = ["192.168.13.0/24"]
  remote_traffic_selector = ["10.187.13.0/24"]
  depends_on = [ 
    google_compute_forwarding_rule.rule-4-gateway,
    google_compute_forwarding_rule.rule-5-500,
    google_compute_forwarding_rule.rule-6-4500
   ]
}

#Final Destination 2
resource "google_compute_route" "route2" {
  name                = "route2"
  network             = google_compute_network.asia-vpc-tf.name
  dest_range          = "10.187.13.0/24"
  priority            = 1000
   depends_on         = [ google_compute_vpn_tunnel.asia-to-europe-tunnel ]
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-europe-to-asia.id
 
}

#------------------------US Gateway (3)------------------------#
# Peer Connection between Europe and US
resource "google_compute_network_peering" "peering-europe-to-us" {
  name         = "peering-europe-to-us"
  network      = google_compute_network.euro-vpc-tf.self_link
  peer_network = google_compute_network.us-vpc-tf.self_link
}

resource "google_compute_network_peering" "peering-us-to-europe" {
  name         = "peering-us-to-europe"
  network      = google_compute_network.us-vpc-tf.self_link
  peer_network = google_compute_network.euro-vpc-tf.self_link
}