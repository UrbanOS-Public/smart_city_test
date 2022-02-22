defmodule SmartCity.TestDataGeneratorTest do
  use ExUnit.Case

  alias SmartCity.TestDataGenerator, as: TDG

  test "create_dataset/1 creates a valid dataset" do
    assert match?(%SmartCity.Dataset{}, TDG.create_dataset(%{}))
  end

  test "create_dataset/1 makes a valid system name :|" do
    dataset = TDG.create_dataset(%{})

    assert dataset.technical.systemName ==
             "#{dataset.technical.orgName}__#{dataset.technical.dataName}"
  end

  test "create_dataset/1 makes a valid system name :| with overrides" do
    org_name = "my_org"
    data_name = "my_data"

    dataset = TDG.create_dataset(%{technical: %{orgName: org_name, dataName: data_name}})
    assert dataset.technical.systemName == "my_org__my_data"
  end

  test "creates datasets with valid ISO8601 DateTimes for business.modifiedDate" do
    dataset = TDG.create_dataset(%{})

    modified_date = DateTime.from_iso8601(dataset.business.modifiedDate)
    assert elem(modified_date, 0) == :ok
  end

  test "create_ingestion/1 creates a valid ingestion" do
    assert match?(%SmartCity.Ingestion{}, TDG.create_ingestion(%{}))
  end

  test "create_ingestion/1 creates a valid ingestion with overrides" do
    actual_ingestion =
      TDG.create_ingestion(%{
        targetDataset: "hazel_penny",
        allow_duplicates: false,
        transformations: [SmartCity.Ingestion.Transformation.new(%{type: "yo", parameters: %{}})]
      })

    assert match?(
             %SmartCity.Ingestion{},
             actual_ingestion
           )

    assert actual_ingestion.targetDataset == "hazel_penny"
    assert actual_ingestion.allow_duplicates == false
    assert List.first(actual_ingestion.transformations).type == "yo"
  end

  test "create_transformation/1 creates a valid transformation" do
    assert match?(%SmartCity.Ingestion.Transformation{}, TDG.create_transformation(%{}))
  end

  test "create_transformation/1 creates a valid transformation with overrides" do
    actual_transformation =
      TDG.create_transformation(%{
        type: "awesome_transform",
        parameters: %{param1: "huzzah", param2: 42}
      })

    assert match?(%SmartCity.Ingestion.Transformation{}, actual_transformation)

    assert actual_transformation.type == "awesome_transform"
    assert actual_transformation.parameters.param1 == "huzzah"
    assert actual_transformation.parameters.param2 == 42
  end

  test "create_organization/1 creates a valid organization" do
    assert match?(%SmartCity.Organization{}, TDG.create_organization(%{}))
  end

  test "create_data/1 creates valid data" do
    assert match?(%SmartCity.Data{}, TDG.create_data(%{dataset_id: "12"}))
  end

  test "create_dataset uses systemName if given one" do
    assert %{technical: %{systemName: "something"}} =
             TDG.create_dataset(%{technical: %{systemName: "something"}})
  end
end
