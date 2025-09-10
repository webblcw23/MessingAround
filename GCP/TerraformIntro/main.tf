terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.2.0"
    }
  }
}

provider "google" {
  # Configuration options
    project = "gcpproject-lw"
    region  = "us-central1"
    zone    = "us-central1-a"

}


# Create a Vnet/compute network/vpc
resource "google_compute_network" "vpc_network" {
  name = "first-vpc-network"
    auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "vpc_subnet1" {
    name          = "first-vpc-subnet1"
    ip_cidr_range = "10.0.1.0/24"
    region        = "us-central1"
    network       = google_compute_network.vpc_network.id
}

# Create a second subnet
resource "google_compute_subnetwork" "vpc_subnet2" {
    name          = "first-vpc-subnet2"
    ip_cidr_range = "10.0.2.0/24"
    region        = "us-central1"
    network       = google_compute_network.vpc_network.id
}

# Create a VM/Compute Engine
resource "google_compute_instance" "vm" {
  name = "first-vm"
    machine_type = "e2-micro" 
    zone         = "us-central1-a"
    network_interface {
      network = google_compute_network.vpc_network.id
      subnetwork = google_compute_subnetwork.vpc_subnet1.id
    }   
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }
}
