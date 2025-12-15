resource "null_resource" "refreshing_storage_scale_health_play" {
  count = (tobool(var.turn_on) == true && tobool(var.create_scale_cluster) == true && tobool(var.storage_turn_on) == true) ? 1 : 0
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "sudo ansible-playbook -f 50 -i ${local.scale_all_inventory} -l 'storage' ${local.cluster_health_refresh_playbook_path}"
  }
  triggers = {
    build = timestamp()
  }
}

resource "null_resource" "refreshing_compute_scale_health_play" {
  count = (tobool(var.turn_on) == true && tobool(var.create_scale_cluster) == true && tobool(var.compute_turn_on) == true) ? 1 : 0
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "sudo ansible-playbook -f 50 -i ${local.scale_all_inventory} -l 'compute' ${local.cluster_health_refresh_playbook_path}"
  }
  triggers = {
    build = timestamp()
  }
}

resource "null_resource" "remove_scale_host_entry_play" {
  count = (tobool(var.turn_on) == true && tobool(var.create_scale_cluster) == true) ? 1 : 0
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "sudo ansible-playbook -f 50 -i ${local.scale_all_inventory} ${local.remove_hostentry_playbooks_path}"
  }
  triggers = {
    build = timestamp()
  }
}

resource "null_resource" "remove_deployer_host_entry_play" {
  count = (tobool(var.turn_on) == true && tobool(var.create_scale_cluster) == true) ? 1 : 0
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "sudo ansible-playbook -f 50 -i localhost, -c local ${local.remove_hostentry_playbooks_path}"
  }
  triggers = {
    build = timestamp()
  }
  depends_on = [null_resource.remove_scale_host_entry_play]
}
