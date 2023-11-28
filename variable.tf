variable "cluster-name" {
  type        = string
  description = "The name of the RDS cluster"
  default     = "my-cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the RDS cluster will be created"
  default     = "vpc-12345678"
}

variable "cidr" {
  type        = string
  description = "CIDR block for inbound security group rules"
  default     = "0.0.0.0/0"
}

variable "public-subnet-1" {
  type        = string
  description = "ID of the first public subnet"
  default     = "subnet-12345678"
}

variable "public-subnet-2" {
  type        = string
  description = "ID of the second public subnet"
  default     = "subnet-87654321"
}

variable "public-subnet-3" {
  type        = string
  description = "ID of the third public subnet"
  default     = "subnet-98765432"
}

variable "db_cluster_identifier" {
  type        = string
  description = "Identifier for the DB cluster snapshot"
  default     = "my-db-cluster"
}

variable "instance_class" {
  type        = string
  description = "The instance class of the RDS cluster instance"
  default     = "db.t2.small"
}

variable "postgres-engine-version" {
  type        = string
  description = "The version of the PostgreSQL engine"
  default     = "10.7"
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Whether to copy tags to DB snapshots"
  default     = true
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether the RDS cluster should be publicly accessible"
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Whether changes should be applied immediately"
  default     = true
}

variable "promotion_tier" {
  type        = number
  description = "The instance's priority during failover"
  default     = 1
}

variable "db-name" {
  type        = string
  description = "The name of the initial database"
  default     = "mydatabase"
}

variable "db-username" {
  type        = string
  description = "Master username for the RDS cluster"
  default     = "admin"
}

variable "db-password" {
  type        = string
  description = "Master password for the RDS cluster"
  default     = "password123"
}

variable "backup_retention_period" {
  type        = number
  description = "The number of days to retain backups"
  default     = 7
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key for encryption"
  default     = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-a123-456a-a12b-a123b4cd5678"
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range for backups"
  default     = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The weekly time range for maintenance"
  default     = "sun:10:00-sun:11:00"
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Whether to copy tags to DB snapshots"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "Whether deletion protection is enabled for the RDS cluster"
  default     = false
}

variable "env" {
  type        = string
  description = "Environment tag for resources"
  default     = "dev"
}
