from pytest_terraform import terraform

import pytest

#Problem: Child compartments are not actually created inside of the parent compartment, Pytest creates them as their own compartment
#This will be validated in the integration tests

#validate default parent compartment name
@pytest.mark.unit
@terraform("parent_compartment", scope="session")
def test_parent_compartment_name(parent_compartment):
    expected_compartment_name = "Parent_Compartment_test_sandbox"
    actual_compartment_name = parent_compartment["oci_identity_compartment.parent_compartment.name"]
    assert expected_compartment_name == actual_compartment_name

#validate default common infra compartment
@pytest.mark.unit
@terraform("common_infra_compartment", scope="session")
def test_common_infra_compartment_name(common_infra_compartment):
    expected_compartment_name = "Common_Infra_Compartment_test_sandbox"
    actual_compartment_name = common_infra_compartment["oci_identity_compartment.common_infra_compartment.name"]
    assert expected_compartment_name == actual_compartment_name

#validate default network compartment name
@pytest.mark.unit
@terraform("network_compartment", scope="session")
def test_network_compartment_name(network_compartment):
    expected_compartment_name = "Network_Compartment_test_sandbox"
    actual_compartment_name = network_compartment["oci_identity_compartment.network_compartment.name"]
    assert expected_compartment_name == actual_compartment_name

#validate default security compartment name
@pytest.mark.unit
@terraform("security_compartment", scope="session")
def test_security_compartment_name(security_compartment):
    expected_compartment_name = "Security_Compartment_test_sandbox"
    actual_compartment_name = security_compartment["oci_identity_compartment.security_compartment.name"]
    assert expected_compartment_name == actual_compartment_name

#validate default applications compartment name
@pytest.mark.unit
@terraform("applications_compartment", scope="session")
def test_applications_compartment_name(applications_compartment):
    expected_compartment_name = "Applications_Compartment_test_sandbox"
    actual_compartment_name = applications_compartment["oci_identity_compartment.applications_compartment.name"]
    assert expected_compartment_name == actual_compartment_name

