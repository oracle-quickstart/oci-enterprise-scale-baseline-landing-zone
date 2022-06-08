data "oci_core_subnet" "external_subnets" {
  for_each  = toset(var.external_subnet_ocids)
  subnet_id = each.value
}