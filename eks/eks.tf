#EKS Role

resource "aws_iam_role" "cluster_role" {
  name               = "${var.app}-cluster-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_eks_cluster_policy" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


#EKS Cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.app}-cluster"
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.cluster_version


  vpc_config {
    subnet_ids         =  concat(var.private_subnets, var.public_subnets)
#    security_group_ids = ["sg-12345678"]  
    endpoint_public_access = true
  }
}

