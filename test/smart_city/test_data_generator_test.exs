defmodule SmartCity.TestDataGeneratorTest do
  use ExUnit.Case

  alias SmartCity.TestDataGenerator, as: TDG

  test "create_dataset/1 creates a valid dataset" do
    assert match?(%SmartCity.Dataset{}, TDG.create_dataset(%{}))
  end

  test "creates datasets with valid ISO8601 DateTimes for business.modifiedDate" do
    dataset = TDG.create_dataset(%{})

    modified_date = DateTime.from_iso8601(dataset.business.modifiedDate)
    assert elem(modified_date, 0) == :ok
  end

  test "create_organization/1 creates a valid organization" do
    assert match?(%SmartCity.Organization{}, TDG.create_organization(%{}))
  end

  test "create_data/1 creates valid data" do
    assert match?(%SmartCity.Data{}, TDG.create_data(%{dataset_id: "12"}))
  end
end
