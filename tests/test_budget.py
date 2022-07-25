from boto3 import Session
from pytest_terraform import terraform

import pytest
import json
import test_vars_helper

data = {
    "tenancy_ocid": "ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq",
    "budget_amount": "100000",
    "budget_target_name": "budget-test-target-name",
    "budget_target": "ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq",
    "budget_alert_rule_threshold": "100",
    "budget_alert_rule_recipients": "example3@test.com",
    "tag_cost_center": "example_tag_cost_center",
    "tag_geo_location": "example_tag_geo_location",
}

test_vars_helper.create_var_files(data)

#unit tests for budget module
@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_target_name(budget):
    actual_budget_target_name = budget["oci_budget_budget.oci_budget.display_name"]
    expected_budget_target_name = "budget-test-target-name-budget"
    assert actual_budget_target_name == expected_budget_target_name

@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_amount(budget):
    actual_budget_amount = budget["oci_budget_budget.oci_budget.amount"]
    expected_budget_amount = 100000
    assert actual_budget_amount == expected_budget_amount

@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_alert_rule_threshold(budget):
    actual_budget_alert_rule_threshold = budget["oci_budget_alert_rule.oci_budget_rule.threshold"]
    expected_budget_alert_rule_threshold = 100
    assert actual_budget_alert_rule_threshold == expected_budget_alert_rule_threshold

@pytest.mark.unit
@terraform("budget", scope="session")
def test_oci_budget_alert_rule_recipients(budget):
    actual_budget_alert_rule_recipients = budget["oci_budget_alert_rule.oci_budget_rule.recipients"]
    expected_budget_alert_rule_recipients = "example3@test.com"
    assert actual_budget_alert_rule_recipients == expected_budget_alert_rule_recipients
