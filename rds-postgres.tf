resource "aws_security_group" "rds" {
  name   = "${var.cluster-name}-postgres-db-security-group"
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = [var.cidr]
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [ingress]
  }

  tags = {
    Name        = "${var.cluster-name}-postgres-db-security-group"
    Environment = var.env
  }

}

resource "aws_db_subnet_group" "rds-subnet" {
  name       = "${var.cluster-name}-postgres-db-subnet"
  subnet_ids = [var.public-subnet-1, var.public-subnet-2, var.public-subnet-3]

  tags = {
    Name        = "${var.cluster-name}-postgres-db-subnet"
    Environment = var.env
  }
}


resource "aws_db_cluster_snapshot" "unencrypted_snapshot" {
  db_cluster_identifier          = var.db_cluster_identifier
  db_cluster_snapshot_identifier = "${var.cluster-name}-aurora-unencrypted-snapshot"
}


resource "aws_rds_cluster_instance" "postgres" {
  identifier                      = "${var.cluster-name}-aurora-postgres-db"
  cluster_identifier              = aws_rds_cluster.postgres.id
  instance_class                  = var.instance_class
  engine                          = aws_rds_cluster.postgres.engine
  engine_version                  = var.postgres-engine-version
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  publicly_accessible             = var.publicly_accessible
  apply_immediately               = var.apply_immediately
  promotion_tier                  = var.promotion_tier
  tags = {
    "Name"        = aws_rds_cluster.postgres.cluster_identifier
    "version"     = var.postgres-engine-version
    "Environment" = var.env
    "terraform"   = "true"
  }
}

resource "aws_rds_cluster" "postgres" {
  cluster_identifier              = "${var.cluster-name}-aurora-postgres-db-cluster"
  engine                          = var.engine
  engine_version                  = var.postgres-engine-version
  database_name                   = var.db-name
  master_username                 = var.db-username
  master_password                 = var.db-password
  db_subnet_group_name            = aws_db_subnet_group.rds-subnet.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  port                            = 5432
  availability_zones              = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  skip_final_snapshot             = true
  apply_immediately               = true
  backup_retention_period         = var.backup_retention_period
  snapshot_identifier             = aws_db_cluster_snapshot.unencrypted_snapshot.id
  storage_encrypted               = true 
  kms_key_id                      = var.kms_key_id
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  deletion_protection             = var.deletion_protection
  
  tags = {
    "Name"        = "${var.cluster-name}-aurora-postgres-db-cluster"
    "version"     = var.postgres-engine-version
    "Environment" = var.env
    "terraform"   = "true"    
  }
}
