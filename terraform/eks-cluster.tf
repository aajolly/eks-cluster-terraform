#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "eksServiceRole" {
  name = "eksServiceRole"

  assume_role_policy = <<POLICY
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
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-lab-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksServiceRole.name
}

resource "aws_iam_role_policy_attachment" "eks-lab-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eksServiceRole.name
}

resource "aws_security_group" "eks-cluster-sg" {
  name        = "eks-lab-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-secGrp"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster-sg.id
  source_security_group_id = aws_security_group.eks-worker-node-sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_cloudwatch_log_group" "eks-cluster-lg" {
  name = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}

resource "aws_eks_cluster" "eksLab-Cluster" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eksServiceRole.arn
  version                   = 1.15
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids         = aws_subnet.eks-private-subnets[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-lab-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-lab-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.eks-cluster-lg
  ]
}

resource "aws_iam_openid_connect_provider" "eks-oidc-provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = []
  url             = "${aws_eks_cluster.eksLab-Cluster.identity.0.oidc.0.issuer}"
}