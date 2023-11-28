# Terraform Module: Encrypted RDS Cluster Creation

This Terraform module automates the process of creating a new encrypted Amazon RDS cluster using a snapshot from an existing RDS cluster. It is designed to simplify the migration to an encrypted database environment.

## Features

- Takes the cluster identifier of an existing RDS cluster as input.
- Creates a new RDS cluster with encryption enabled using a snapshot of the specified old cluster.
- Supports configuration of various parameters such as instance class, backup retention, maintenance windows, and more.

## Usage

1. Specify the old RDS cluster identifier as input.
2. Configure additional parameters in the module as needed.
3. Run Terraform apply to provision the new encrypted RDS cluster.

## Example

module "encrypted_rds_cluster" {
  source                  = "path/to/encrypted-rds-cluster"
  old_cluster_identifier = "existing-rds-cluster"
  // Additional configuration parameters...
}
