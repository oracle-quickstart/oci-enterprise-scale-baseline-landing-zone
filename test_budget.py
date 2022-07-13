from boto3 import Session
from pytest_terraform import terraform

import pytest
import tftest

#validate creation of budget resources
#validate proper resources are created in the correct parent compartment when budgets are enabled

@terraform("budget", scope="session")
def test_oci_budget_amount(budget):
    actual_budget_amount = budget.outputs["budget_amount"]
    expected_budget_amount = {"value": 10000, "type": "number"}
    assert "budget_amount" in budget.outputs
    assert actual_budget_amount == expected_budget_amount

@terraform("budget", scope="session")
def test_oci_budget_alert_rule_threshold(budget):
    actual_budget_alert_rule_threshold = budget.outputs["budget_alert_rule_threshold"]
    expected_budget_alert_rule_threshold = {"value": 100, "type": "number"}
    assert "budget_alert_rule_threshold" in budget.outputs
    assert actual_budget_alert_rule_threshold == expected_budget_alert_rule_threshold

@terraform("budget", scope="session")
def test_oci_budget_alert_rule_recipients(budget):
    actual_budget_alert_rule_recipients = budget.outputs["budget_alert_rule_recipients"]
    expected_budget_alert_rule_recipients = {"value": "example3@test.com", "type": "string"}
    assert "budget_alert_rule_recipients" in budget.outputs
    assert actual_budget_alert_rule_recipients == expected_budget_alert_rule_recipients

