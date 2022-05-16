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
        name: "Noodle",
        allow_duplicates: false,
        transformations: [TDG.create_transformation(%{type: "type"})]
      })

    assert match?(
             %SmartCity.Ingestion{},
             actual_ingestion
           )

    assert actual_ingestion.targetDataset == "hazel_penny"
    assert actual_ingestion.name == "Noodle"
    assert actual_ingestion.allow_duplicates == false
    assert List.first(actual_ingestion.transformations).type == "type"
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

  test "create_access_group/1 creates a valid access group" do
    assert match?(%SmartCity.AccessGroup{}, TDG.create_access_group(%{}))
  end

  test "create_access_group/1 creates a valid access group with overriders" do
    access_group = TDG.create_access_group(%{name: "penny", description: "Penny Access Group"})
    assert match?(%SmartCity.AccessGroup{}, access_group)
    assert access_group.name == "penny"
    assert access_group.description == "Penny Access Group"
  end

  test "create_data/1 creates valid data" do
    assert match?(%SmartCity.Data{}, TDG.create_data(%{dataset_id: "12"}))
  end

  test "create_data/1 accepts overrides" do
    metadata = %{
      "org" => "best_org",
      "name" => "good_data",
      "stream" => true
    }

    timing = %{
      "start_time" => "2022-05-16T19:11:15+0000",
      "end_time" => "2022-05-16T19:12:15+0000",
      "app" => "something",
      "label" => "optimal"
    }

    operational = %{
      "timing" => [timing]
    }

    payload = %{
      "thing" => "yay",
      "other_thing" => "nah"
    }

    overrides = %{
      "dataset_id" => "dataset123",
      "ingestion_id" => "ingestion456",
      "extraction_start_time" => "2022-05-16T19:11:15+0000",
      "_metadata" => metadata,
      "operational" => operational,
      "payload" => payload
    }

    data = TDG.create_data(overrides)
    assert Map.get(overrides, "dataset_id") == data.dataset_id
    assert Map.get(overrides, "ingestion_id") == data.ingestion_id
    assert Map.get(overrides, "extraction_start_time") == data.extraction_start_time
    assert Map.get(metadata, "org") == data._metadata.org
    assert Map.get(metadata, "name") == data._metadata.name
    assert Map.get(metadata, "stream") == data._metadata.stream
    [first_timing | _] = data.operational.timing
    assert Map.get(timing, "start_time") == first_timing.start_time
    assert Map.get(timing, "end_time") == first_timing.end_time
    assert Map.get(timing, "app") == first_timing.app
    assert Map.get(timing, "label") == first_timing.label
    assert payload == data.payload
  end

  test "create_dataset uses systemName if given one" do
    assert %{technical: %{systemName: "something"}} =
             TDG.create_dataset(%{technical: %{systemName: "something"}})
  end

  test "create_user/1 creates a valid user" do
    user = TDG.create_user(%{})
    refute user.subject_id == nil
    refute user.email == nil
    refute user.name == nil
  end

  test "create_user/1 overrides user fields with overrides" do
    overrides = %{subject_id: "auth0|000000", email: "override@example.com", name: "Custom User"}
    user = TDG.create_user(overrides)
    assert user.subject_id == overrides.subject_id
    assert user.email == overrides.email
    assert user.name == overrides.name
  end
end
