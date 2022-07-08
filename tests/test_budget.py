from boto3 import Session
from pytest_terraform import terraform

import pytest
import tftest

#validate creation of budget resources
#validate proper resources are created in the correct parent compartment when budgets are enabled

@terraform("../budget", scope="session", name="tf")
def test_oci_budget_amount(tf):
    print("test invoked budget amount")
    print(tf["budget_amount"])
    assert "budget_amount" in tf["budget_amount"]

@terraform("../budget", scope="session")
def test_oci_budget_alert_rule_threshold(budget):
    print(budget.outputs["budget_alert_rule_threshold"])
    assert "budget_alert_rule_threshold" in budget.outputs["budget_alert_rule_threshold"]

@terraform("budget", scope="session")
def test_oci_budget_alert_rule_recipients(budget):
    print(budget.outputs["budget_alert_rule_recipients"])
    assert "budget_alert_rule_recipients" in budget.outputs["budget_alert_rule_recipients"]

#validate resources are not created when budgets are disabled
@terraform("budget", scope="session")
def test_budget_resources_disabled(budget):
    assert "budget_amount" in budget["budget_amount"] is None
    assert "budget_alert_rule_threshold" in budget["budget_alert_rule_threshold"] is None
    assert "budget_alert_rule_recipients" in budget["budget_alert_rule_recipients"] is None