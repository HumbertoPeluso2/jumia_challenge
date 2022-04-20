resource "null_resource" "install-jenkins"{
   provisioner "local-exec" {
    working_dir = "./jenkins"
    command = "ansible-playbook jenkins-install.yaml"
  }
  depends_on = [
    aws_eks_cluster.cluster
  ]
}