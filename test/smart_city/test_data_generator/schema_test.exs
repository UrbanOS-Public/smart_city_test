defmodule SmartCity.TestDataGenerator.SchemaTest do
  use ExUnit.Case
  doctest SmartCity.TestDataGenerator.Schema
  alias SmartCity.TestDataGenerator.Schema

  test "basic schema" do
    actual = Schema.get(:basic)

    assert actual = %{
      "schema" => [
        %{
          name: "id",
          type: "integer",
          ingestion_field_selector: "id"
        },
        %{
          name: "name",
          type: "string",
          ingestion_field_selector: "name"
        }
      ]
    }
  end

  test "big data schema" do
    actual = Schema.get(:big_data)

    assert actual = %{
      "schema" => [
        %{
          name: "big",
          type: "string",
          ingestion_field_selector: "big"
        },
        %{
          name: "bigbig",
          type: "integer",
          ingestion_field_selector: "bigbig"
        },
        %{
          name: "data",
          type: "float",
          ingestion_field_selector: "data"
        },
        %{
          name: "bigger_data",
          type: "date",
          format: "{ISO:Extended:Z}",
          ingestion_field_selector: "bigger_data"
        }
      ]
    }
  end

  test "pirate dilemma schema" do
    actual = Schema.get(:pirate_dilemma)

    assert actual = %{
      "schema" => [
        %{
          name: "go",
          type: "integer",
          ingestion_field_selector: "go"
        },
        %{
          name: "fund",
          type: "string",
          ingestion_field_selector: "fund"
        },
        %{
          name: "yourself",
          type: "string",
          ingestion_field_selector: "yourself"
        }
      ]
    }
  end

  test "test schema" do
    actual = Schema.get(:basic)

    assert actual = %{
      "schema" => [
        %{
          name: "my_int",
          type: "integer",
          ingestion_field_selector: "my_int"
        },
        %{
          name: "my_string",
          type: "string",
          ingestion_field_selector: "my_string"
        },
        %{
          name: "my_date",
          type: "date",
          format: "{ISO:Extended:Z}",
          ingestion_field_selector: "my_date"
        },
        %{
          name: "my_float",
          type: "float",
          ingestion_field_selector: "my_float"
        },
        %{
          name: "my_boolean",
          type: "boolean",
          ingestion_field_selector: "my_boolean"
        }
      ]
    }
  end

  test "error schema" do
    actual = Schema.get(:invalid)

    assert actual = {:error, "Schema not found"}
  end
end
