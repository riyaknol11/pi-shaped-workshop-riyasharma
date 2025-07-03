output "instance_name" {
  description = "Name of the created VM instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_id" {
  description = "ID of the created VM instance"
  value       = google_compute_instance.vm_instance.id
}

output "internal_ip" {
  description = "Internal IP address of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "external_ip" {
  description = "External IP address of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "self_link" {
  description = "Self link of the VM instance"
  value       = google_compute_instance.vm_instance.self_link
}