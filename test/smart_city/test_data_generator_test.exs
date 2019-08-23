defmodule SmartCity.TestDataGeneratorTest do
  use ExUnit.Case

  alias SmartCity.TestDataGenerator, as: TDG

  test "create_dataset/1 creates a valid dataset" do
    assert match?(%SmartCity.Event.DatasetUpdate{}, TDG.create_dataset(%{}))
  end

  test "create_organization/1 creates a valid organization" do
    assert match?(%SmartCity.Event.OrganizationUpdate{}, TDG.create_organization(%{}))
  end

  test "create_data/1 creates valid data" do
    assert match?(%SmartCity.Data{}, TDG.create_data(%{dataset_id: "12"}))
  end
end
