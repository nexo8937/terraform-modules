#ECR & Permissions

#----------------ECR----------------

resource "aws_ecr_repository" "ecr-repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.app}-ecr-${var.env}"
  }

}


#----------------Role & Policy----------------

##EC2 Role
#resource "aws_iam_role" "ecr_role" {
#  name = "ecr-role"

#  assume_role_policy = jsonencode({
#    Version   = "2012-10-17"
#    Statement = [{
#      Effect    = "Allow"
#      Principal = {
#        Service = "ec2.amazonaws.com"
#      }
#      Action    = "sts:AssumeRole"
#    }]
#  })
#}

##Attach Policy to Role
#resource "aws_iam_policy_attachment" "ecr_policy_attachment" {
#  name       = "AmazonEC2ContainerRegistryFullAccess"
#  roles      = [aws_iam_role.ecr_role.name]
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
#}

##EC2 Instance Profile
#resource "aws_iam_instance_profile" "ecr_instance_profile" {
#  name = "${var.app}-ecr-instance-profile"
#  role = aws_iam_role.ecr_role.name
#}
