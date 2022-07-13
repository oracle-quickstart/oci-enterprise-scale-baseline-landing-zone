from boto3 import Session
from pytest_terraform import terraform

import pytest
import tftest


#validate parent compartment name
@terraform("/compartments/parent-comparment", scope="session", name="parent_compartment")
def test_parent_compartment(parent_compartment):
    expected_compartment_name = "Parent Compartment"
    actual_compartment_name = parent_compartment.outputs["parent_compartment_name"]
    actual_compartment_name2 = parent_compartment.resources["oci_identity_compartment.parent_compartment.name"]
    assert expected_compartment_name == actual_compartment_name
    assert expected_compartment_name == actual_compartment_name2
    assert actual_compartment_name == actual_compartment_name2

#validate default network compartment name
@terraform("/compartments/network-comparment", scope="session", name="network_compartment")
def test_network_compartment(network_compartment):
    expected_compartment_name = "Network Compartment"
    actual_compartment_name = network_compartment.outputs["network_compartment_name"]
    actual_compartment_name_default = network_compartment.resources["oci_identity_compartment.network_compartment.name"]
    assert expected_compartment_name == actual_compartment_name
    assert expected_compartment_name == actual_compartment_name_default
    assert actual_compartment_name == actual_compartment_name_default

#validate default security compartment name
@terraform("/compartments/network-comparment", scope="session", name="security_compartment")
def test_security_compartment(security_compartment):
    expected_compartment_name = "Security Compartment"
    actual_compartment_name = security_compartment.outputs["network_compartment_name"]
    actual_compartment_name_default = security_compartment.resources["oci_identity_compartment.network_compartment.name"]
    assert expected_compartment_name == actual_compartment_name
    assert expected_compartment_name == actual_compartment_name_default
    assert actual_compartment_name == actual_compartment_name_default