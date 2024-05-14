
# Europe
output "website_url" {
  value = google_compute_instance.euro-web-server.network_interface.0.access_config.0.nat_ip
}
output "Europe_internal_IP" {
  value = google_compute_instance.euro-web-server.network_interface.0.network_ip
}
output "Europe_external_IP" {
  value = google_compute_instance.euro-web-server.network_interface.0.access_config.0.nat_ip
}
output "Europe_subnet" {
  value = google_compute_subnetwork.euro-subnet-tf.ip_cidr_range
}
output "Europe_subnet_ip_range" {
  value = google_compute_subnetwork.euro-subnet-tf.ip_cidr_range
}

# Asia

output "Asia_vpc_name" {
  value = google_compute_network.asia-vpc-tf.name
}
output "Asia_internal_IP" {
  value = google_compute_instance.asia-vm-instance.network_interface.0.network_ip
}
output "Asia_external_IP" {
  value = google_compute_instance.asia-vm-instance.network_interface.0.access_config.0.nat_ip
}   
output "Asia_subnet_ip_range" {
  value = google_compute_subnetwork.asia-subnet-tf.ip_cidr_range
}
output "Asia_subnet_name" {
  value = google_compute_subnetwork.asia-subnet-tf.name
}



# Americas

output "us_vpc_name" {
  value = google_compute_network.us-vpc-tf.name
}

# US_1
output "us_vm_instance1_interna_IP" {
  value = google_compute_instance.us-vm-instance1.network_interface.0.network_ip
}
output "us_vm_instance1_externa_IP" {
  value = google_compute_instance.us-vm-instance1.network_interface.0.access_config.0.nat_ip
}
output "us_subnet1_ip_range" {
  value = google_compute_subnetwork.us-subnet1-tf.ip_cidr_range
}
output "us_subnet1_name" {
  value = google_compute_subnetwork.us-subnet1-tf.name
}

# US_2
output "us_vm_instance2_interna_IP" {
  value = google_compute_instance.us-vm-instance2.network_interface.0.network_ip
}
output "us_vm_instance2_externa_IP" {
  value = google_compute_instance.us-vm-instance2.network_interface.0.access_config.0.nat_ip
}
